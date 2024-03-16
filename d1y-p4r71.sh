sed -i '1 i\src-git ace8 https://github.com/0xACE8/4c38-p4ck463;main' feeds.conf.default
#sed -i '2 i\src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git;main' feeds.conf.default
sed -i '2 i\src-git passwall_packages https://github.com/sbwml/openwrt_helloworld' feeds.conf.default
sed -i '$a src-git passwall2 https://github.com/xiaorouji/openwrt-passwall2.git;main' feeds.conf.default
sed -i '$a src-git mosdns https://github.com/0xACE8/luci-app-mosdns;v5' feeds.conf.default

