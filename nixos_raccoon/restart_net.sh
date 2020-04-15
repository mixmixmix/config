sudo systemctl stop NetworkManager.service
sudo systemctl stop wpa_supplicant.service 
sleep 10
sudo systemctl start wpa_supplicant.service
sudo systemctl start NetworkManager.service

