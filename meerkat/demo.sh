set -i
cd meerkat_infrastructure/dev/
sudo service docker start
sudo docker-compose -f mad.yml up -d
sudo docker exec -ti dev_frontend_1 bash
