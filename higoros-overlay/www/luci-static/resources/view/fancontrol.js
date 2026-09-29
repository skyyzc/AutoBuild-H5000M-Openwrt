'use strict';
'require view';

/*
 * 风扇控制 LuCI 入口（占位页）。
 * 真正的风扇控制界面在海狗（HigoOS）首页 —— 80 端口的「系统管理 → 风扇控制」。
 * 本页只做跳转，避免 8080 传统 LuCI 里出现死链接。
 */
return L.view.extend({
	render: function () {
		window.location.replace('/');
		return E('div', { style: 'padding:2em;color:#888' },
			'风扇控制在海狗管理页（80 端口）「系统管理 → 风扇控制」，正在跳转…');
	}
});
