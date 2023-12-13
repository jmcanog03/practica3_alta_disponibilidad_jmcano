echo "comandos para atualizar repositorios"
sudo apt -y update
sudo apt -y upgrade

echo "comandos instalar el servidor web nginx y el cliente nfs"
sudo apt install -y nginx
sudo apt install -y nfs-common


echo "quitar la red"

sudo ip route del default