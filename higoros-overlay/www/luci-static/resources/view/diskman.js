'use strict';
'require view';

/*
 * 磁盘管理 LuCI 入口（占位页）。
 * 真正的磁盘管理界面在海狗（HigoOS）首页 —— 80 端口的「存储管理」。
 * 本页只做跳转，避免 8080 传统 LuCI 里出现死链接。
 */
return L.view.extend({
	render: function () {
		window.location.replace('/');
		return E('div', { style: 'padding:2em;color:#888' },
			'磁盘管理在海狗管理页（80 端口）「存储管理」，正在跳转…');
	}
});
