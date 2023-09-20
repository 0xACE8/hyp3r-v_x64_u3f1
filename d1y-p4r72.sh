#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: 0xACE7
#=================================================
# Modify default IP
sed -i 's/192.168.1.1/192.168.177.80/g' package/base-files/files/bin/config_generate

# Password is ********
#sed -i "s/root::0:0:99999:7:::/root:$1$4xKZB45Q$w0CPT5M6vBWbYNmSWuxfU.:19007:0:99999:7:::/g" package/base-files/files/etc/shadow

# Change language=auto to zh_cn
sed -i 's/lang="auto"/lang="zh_cn"/g' package/emortal/default-settings/files/99-default-settings

# Modify Ntp server
#sed -i 's/ntp.tencent.com/ntp.ntsc.ac.cn/g' package/emortal/default-settings/files/99-default-settings-chinese
#sed -i 's/ntp1.aliyun.com/cn.ntp.org.cn/g' package/emortal/default-settings/files/99-default-settings-chinese
#sed -i 's/ntp.tencent.com/edu.ntp.org.cn/g' package/emortal/default-settings/files/99-default-settings-chinese
#sed -i 's/ntp.tencent.com/ntp.tuna.tsinghua.edu.cn/g' package/emortal/default-settings/files/99-default-settings-chinese

# Change luci list name
sed -i 's/"Argon 主题设置"/"主题设置"/g' feeds/luci/applications/luci-app-argon-config/po/zh_Hans/argon-config.po

# change some tips
sed -i 's/"终端"/"TTYD 终端"/g' feeds/luci/applications/luci-app-ttyd/po/zh_Hans/ttyd.po

sed -i 's/START=18/START=99/g' feeds/packages/net/dnscrypt-proxy2/files/dnscrypt-proxy.init

# install turboacc and patch
#echo "install turboacc and patch for nftables"
#ls
#mkdir -p turboacc_tmp ./package/turboacc
#cd turboacc_tmp
#git clone https://github.com/chenmozhijin/turboacc -b package
#cd ../package/turboacc
#git clone https://github.com/fullcone-nat-nftables/nft-fullcone
#git clone https://github.com/chenmozhijin/turboacc
#mv ./turboacc/luci-app-turboacc ./luci-app-turboacc
#rm -rf ./turboacc
#cd ../..
#cp -f turboacc_tmp/turboacc/hack-5.15/952-add-net-conntrack-events-support-multiple-registrant.patch ./target/linux/generic/hack-5.15/952-add-net-conntrack-events-support-multiple-registrant.patch
#cp -f turboacc_tmp/turboacc/hack-5.15/953-net-patch-linux-kernel-to-support-shortcut-fe.patch ./target/linux/generic/hack-5.15/953-net-patch-linux-kernel-to-support-shortcut-fe.patch
#cp -f turboacc_tmp/turboacc/pending-5.15/613-netfilter_optional_tcp_window_check.patch ./target/linux/generic/pending-5.15/613-netfilter_optional_tcp_window_check.patch
#rm -rf ./package/libs/libnftnl ./package/network/config/firewall4 ./package/network/utils/nftables
#mkdir -p ./package/network/config/firewall4 ./package/libs/libnftnl ./package/network/utils/nftables
#cp -r ./turboacc_tmp/turboacc/shortcut-fe ./package/turboacc
#cp -RT ./turboacc_tmp/turboacc/firewall4-$(grep -o 'FIREWALL4_VERSION=.*' ./turboacc_tmp/turboacc/version | cut -d '=' -f 2)/firewall4 ./package/network/config/firewall4
#cp -RT ./turboacc_tmp/turboacc/libnftnl-$(grep -o 'LIBNFTNL_VERSION=.*' ./turboacc_tmp/turboacc/version | cut -d '=' -f 2)/libnftnl ./package/libs/libnftnl
#cp -RT ./turboacc_tmp/turboacc/nftables-$(grep -o 'NFTABLES_VERSION=.*' ./turboacc_tmp/turboacc/version | cut -d '=' -f 2)/nftables ./package/network/utils/nftables
#rm -rf turboacc_tmp
#echo "# CONFIG_NF_CONNTRACK_CHAIN_EVENTS is not set" >> target/linux/generic/config-5.15
#echo "# CONFIG_SHORTCUT_FE is not set" >> target/linux/generic/config-5.15
#sed -i 's/Turbo ACC 网络加速/网络加速/g' package/turboacc/luci-app-turboacc/po/zh-cn/turboacc.po
#echo "install turboacc done!"

# Boost UDP
echo '# optimize udp' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.rmem_max=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.rmem_default=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.wmem_max=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.wmem_default=26214400' >>package/base-files/files/etc/sysctl.d/10-default.conf
echo 'net.core.netdev_max_backlog=2048' >>package/base-files/files/etc/sysctl.d/10-default.conf

# Change to my banner
sudo rm package/base-files/files/etc/banner
wget --no-check-certificate https://raw.githubusercontent.com/0xACE8/hyp3r-v_x64_u3f1/main/banner -O package/base-files/files/etc/banner

# upgrade 99-default-settings-chinese.sh
rm -rf package/emortal/default-settings/files/99-default-settings-chinese.sh
wget --no-check-certificate https://raw.githubusercontent.com/0xACE8/hyp3r-v_x64_u3f1/main/99-default-settings-chinese.sh -O package/emortal/default-settings/files/99-default-settings-chinese.sh

# upgrade config
wget --no-check-certificate https://raw.githubusercontent.com/0xACE8/hyp3r-v_x64_u3f1/main/99-init-settings -O package/base-files/files/etc/uci-defaults/99-init-settings

# add dns list
mkdir -p package/base-files/files/etc/dnsmasq.d
wget --no-check-certificate -O package/base-files/files/etc/dnsmasq.d/accelerated-domains.china.conf "https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf"

echo "diy-part2.sh is done."
