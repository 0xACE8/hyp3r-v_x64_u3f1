#!/bin/sh

sed -i 's/root::0:0:99999:7:::/root:$1$4xKZB45Q$w0CPT5M6vBWbYNmSWuxfU.:0:0:99999:7:::/g' /etc/shadow
sed -i 's/root:::0:99999:7:::/root:$1$4xKZB45Q$w0CPT5M6vBWbYNmSWuxfU.:0:0:99999:7:::/g' /etc/shadow

uci set luci.main.lang=zh_cn
uci commit luci

uci -q get system.@imm_init[0] > "/dev/null" || uci -q add system imm_init > "/dev/null"

if ! uci -q get system.@imm_init[0].system_chn > "/dev/null"; then
        uci -q batch <<-EOF
                set system.@system[0].hostname='Bypass_Router'
                set system.@system[0].timezone="PST8PDT,M3.2.0,M11.1.0"
                set system.@system[0].zonename="America/Los Angeles"
                set system.ntp.use_dhcp='0'

                delete system.ntp.server
                add_list system.ntp.server="cn.ntp.org.cn"
                add_list system.ntp.server="edu.ntp.org.cn"
                add_list system.ntp.server="ntp.ntsc.ac.cn"
                add_list system.ntp.server="ntp.tuna.tsinghua.edu.cn"

                set system.@imm_init[0].system_chn="1"
                commit system
        EOF
fi

exit 0
