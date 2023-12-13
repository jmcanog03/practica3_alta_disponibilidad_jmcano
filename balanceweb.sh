echo "Actualizar los repositorios"
sudo apt -y update
sudo apt -y upgrade

echo "Instalar nginx servidor web"
sudo apt install -y nginx

echo "quitar la red"

sudo ip route del default