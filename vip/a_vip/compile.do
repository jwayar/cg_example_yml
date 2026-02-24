# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#                    ______          __            __                         :
#                   / ____/___ ___  / /____  _____/ /_                        :
#                  / __/ / __ `__ \/ __/ _ \/ ___/ __ \                       :
#                 / /___/ / / / / / /_/  __/ /__/ / / /                       :
#                /_____/_/ /_/ /_/\__/\___/\___/_/ /_/                        :
#                                                                             :
# This file contains confidential and proprietary information of Emtech SA.   :
# Any unauthorized copying, alteration, distribution, transmission,           :
# performance, display or other use of this material is prohibited.           :
# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
# Client             : emtech
# Version            : 1.0
# Application        : Generic
# Filename           : compile.do
# Date Last Modified : 2025 AUG 13
# Date Created       : 2025 AUG 13
# Device             : Generic
# Design Name        : Generic
# Purpose            : A compilation script
# Author(s)          : Joel Wayar
# Email              : jwayar@emtech.com.ar
#
# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# Agent description: Agente abstracto
#

set a_vip_path "$lib_path/vip/a_vip"

# Compile VIPs
vlog -timescale 1ns/1ps +incdir+$a_vip_path \
    "$a_vip_path/a_agent_pkg.sv"       \
    "$a_vip_path/a_if.sv"