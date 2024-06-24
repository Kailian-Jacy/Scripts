#!/bin/bash

WRT_LOGIN=wrt

DEPENDENCY="ddns-scripts luci-app-ddns wget openssl-util"

ALI_DDNS=https://github.com/honwen/luci-app-aliddns/releases/download/v20171205/luci-app-aliddns_0.2.0-1_all.ipk
ALI_DDNS_NAME=luci-app-aliddns_0.2.0-1_all.ipk

OPEN_CLASH=https://github.com/vernesong/OpenClash/releases/download/v0.45.152-beta/luci-app-openclash_0.45.152-beta_all.ipk
OPEN_CLASH_NAME=luci-app-openclash_0.45.152-beta_all.ipk

# Remind: change the architecture!
OPEN_CLASH_CORE=https://github.com/vernesong/OpenClash/releases/download/Clash/clash-linux-armv8.tar.gz

# install openclash
install_openclash(){
	ssh $WRT_LOGIN "sed -i 's_downloads.openwrt.org_mirrors.tuna.tsinghua.edu.cn/openwrt_' /etc/opkg/distfeeds.conf && opkg update"
	ssh $WRT_LOGIN "opkg install coreutils-nohup bash iptables dnsmasq-full curl ca-certificates ipset ip-full iptables-mod-tproxy iptables-mod-extra libcap libcap-bin ruby ruby-yaml kmod-tun kmod-inet-diag unzip luci-compat luci luci-base"
	wget -O $OPEN_CLASH_NAME $OPEN_CLASH
	scp -O $OPEN_CLASH_NAME $WRT_LOGIN:~
	ssh $WRT_LOGIN "opkg install $OPEN_CLASH_NAME"
	wget -O clash.core.tar.gz $OPEN_CLASH_CORE
	scp -O clash.core.tar.gz $WRT_LOGIN:/etc/openclash/core/
}

install_aliddns(){

}
