# wireshark-lua
用来进行流量研判的脚本（熵值检测）
下载Entropy.lua放入wireshark插件中
wireshark → Help → About Wireshark → Folders → "Personal Lua Plugins"。把 Entropy.lua 放这里

最后重启wireshark即可在info列看到熵值
<img width="1770" height="1147" alt="image" src="https://github.com/user-attachments/assets/b5c3c785-01e7-41be-b380-15f95c9c5054" />
附熵值范围说明
场景	       熵值范围  	说明
HTTP纯文本 	   3~5	   ASCII/simple文本
图片/可执行文件  6~8	   有压缩/二进制
TLS加密数据	   7.6~8	 高度随机，理论接近 8
SSH/VPN流量	   7.6~8	 一般为加密/难以识别
恶意流量伪装	   7~8	   伪装流量/加密隧道/隐写
全0/全FF填充包	 0~0.1	 极低熵
