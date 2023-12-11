echo "comandos para actualizar los repositorios"
sudo apt -y  update
sudo apt -y upgrade

echo "Instalar servidor mariadb"
sudo apt install -y mariadb-server

echo "Instalar herramienta para hacer un balanceador en mysql"

sudo apt install -y haproxy
