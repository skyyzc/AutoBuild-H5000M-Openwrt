#!/bin/sh
# HigoOS 保真 overlay —— 首次启动配置（uci-defaults，只跑一次）
# 1) 启用海狗后端与风扇服务
[ -x /etc/init.d/higoros ] && /etc/init.d/higoros enable
[ -x /etc/init.d/fancontrol ] && /etc/init.d/fancontrol enable

# 2) 若底座带了其他风扇后台，禁掉，避免两个控制器抢 pwm
#    （海狗页 + /usr/bin/fancontrol v2 是唯一管理者）
for SVC in h5000m-fancontrol fancontrol-h5000m; do
    [ -x "/etc/init.d/$SVC" ] && /etc/init.d/"$SVC" disable 2>/dev/null
done

# 3) 端口腾挪：higorosd 固定监听 :80（海狗前端），传统 LuCI(uhttpd) 挪 8080/8443
#    与原厂 24.10 布局一致：80 = 海狗，8080 = 传统 LuCI
if [ -f /etc/config/uhttpd ]; then
    uci -q set uhttpd.main.listen_http='0.0.0.0:8080'
    uci -q set uhttpd.main.listen_https='0.0.0.0:8443'
    uci -q commit uhttpd
    /etc/init.d/uhttpd restart 2>/dev/null
fi

# 4) 无线兜底：保证 radio 使能、国家码 CN（mt76 首启一般会自动生成）
uci -q set wireless.radio0.country='CN' 2>/dev/null
uci -q set wireless.radio1.country='CN' 2>/dev/null
uci -q commit wireless 2>/dev/null

exit 0
