echo "actualizar repositorios"
sudo apt -y update
sudo apt -y upgrade

echo "instalar mariadb servidor"

sudo apt install -y mariadb-server


echo "quitar la red"

sudo ip route del default
