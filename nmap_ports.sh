echo "Insert \e[31mtarget's\e[0m address: "
read target_ip
echo ""

ports=$(nmap -p- --min-rate=1000 $target_ip -T4 | grep ^[0-9] | cut -d '/' -f 1 | tr '\n' ',' | sed s/,$//)
touch ports_$target_ip\.txt | echo $ports > ports_$target_ip\.txt
echo "Found ports: \e[32m$ports\e[0m"

echo "\n\e[1;33mPerforming scanning on these ports:\e[0m "
nmap -p$ports -Pn $target_ip -oX scan_$target_ip.xml

echo "\n\e[1;33mConverting to .csv...\e[0m"
python3 nmap_xml_parser.py -f ../scan_$target_ip.xml -csv scan_$target_ip.csv
echo "\e[32m\nDone!\e[0m"
echo "Ports are availiable at:\e[1;34m\nTXT:\e[0m\e[34m\tports_$target_ip.txt\e[0m"
echo "Scan results are availiable at:"
echo "\e[1;34mXML:\e[0m\e[34m\tscan_$target_ip.xml\e[0m"
echo "\e[1;34mCSV:\e[0m\e[34m\tscan_$target_ip.csv\e[0m"
