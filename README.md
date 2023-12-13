# josemanuel-cano-gonz-lez_capas_alta_disponibilidad
Este repositorio es para la práctica Instalación de Wordpress en arquitectura de 3/4 capas en alta disponibilidad 2º de ASIR módulo Implementación de Aplicaciones Web

## ÍNDICE ## 

- [configuracion_balanceadorweb](#configuración-del-balanceador-web)
- [configuración_serverweb1](#configuración-del-servidor-web-1)
- [configuracion_serverweb2](#configuración-del-servidor-web-2)
- [configuracion_servernfs_y_php_y_descargar_wordpress](#descargar-wordpress-en-los-servidores-web-y-nfs-y-configurar-servidor-nfs-y-motor-php)
- [pasos_previos_a_la_instalación_de_wordpress](#pasos-previos-a-la-instalación-de-wordpress)
- [instalación_wordpress](#instalación-y-personalización-de-wordpress)
- [conclusión](#conclusión)



## INTRODUCCIÓN ##

*En esta práctica la estructura será la siguiente en la 1º capa tendremos al balanceador web que usara nginx en la 2º capa tendremos dos servidores nginx y un servidor nfs junto con el motor de php en la 3º capa tendremos un balanceador de mysql y en la 4º capa tendremos dos servidores mysql ambos y el balanceador usaran mariadb-server y haremos un cluster entre estas 3 máquinas con galera para el balanceador utilizaremos la herramienta haproxy toda esta infraestructura estará montada en vagrant el objetivo de la misma es conseguir instalar y personalizar WordPress en esta estructura mencionada.*



## CONFIGURACIÓN DEL BALANCEADOR WEB ##

*El 1º paso es crear el archivo de configuración en la carpeta #conf.d que está en #/etc/nginc/conf.d lo llamaremos load_balancer.conf y le añadiremos lo siguiente.*

![1º imagen](<practica capa 3 balanceadores/balanceadorweb/archivo conf creado .png>)

![2º imagen](<practica capa 3 balanceadores/balanceadorweb/captura 3 añadir al directiva upstream para balancear la carga con nginx.png>)

![3º imagen](image.png)

## CONFIGURACIÓN DEL SERVIDOR WEB 1 ##

*El 1º paso en este servidor es hacer una copia del host virtual por defecto default que le vamos a llamar serverweb1 luego habilitaremos el host virtual con un enlace simbólico y eliminaremos el host virtual por defecto llamado default las carpetas serán /etc/nginx/sites-available que es donde está el host virtual por defecto llamado default y la carpeta sites-enable que esta también en /etc/nginx y es donde están habilitados los host virtuales.*

![4º imagen](<practica capa 3 balanceadores/serverweb1/captura 1 copia del sitio virtual y crear enlace para habilitarlo serveweb1.png>)


*El 2º paso es editar el sitio virtual serverweb1 que está en /ect/nginx/sites-enable y en la línea que pone add index.php dejajo de esa línea hay una lista del orden que nginx buscara los archivos bien en esa línea detrás de index añadiremos index.php y para conectar el serverweb1 con el motor php que está montado en el servidor nfs más abajo descomentaremos la línea location después la línea include snippets y por ultimo descomentamos la última línea que pone fastcgi_pass y pondremos la ip del servidor nfs:9000.*

![6º imagen](<practica capa 3 balanceadores/serverweb1/captura 3 indicando donde esta el motor php .png>)

![7º imagen](<practica capa 3 balanceadores/serverweb1/captura 2 añadir index.php para crearlo despúes y comprobar que funciona.png>)


## CONFIGURACIÓN DEL SERVIDOR WEB 2 ##

*El 1º paso es lo mismo que en el serverweb1 crear el host virtual mediante una copia del host por defecto y hacer un enlace simbólico para su activación e editar el fichero y añadir index.php a la lista e indicar donde está el motor php.*

![9º imagen](<practica capa 3 balanceadores/serverweb2/captura 1 copia del sitio y crear enlace serverweb2.png>)

![10º imagen](<practica capa 3 balanceadores/serverweb2/añadir index.php a la lista.png>)

![11º imagen](<practica capa 3 balanceadores/serverweb2/señalar localizacion motor php.png>)



## DESCARGAR WORDPRESS EN LOS SERVIDORES WEB Y NFS Y CONFIGURAR SERVIDOR NFS Y MOTOR PHP ##

*El 1º paso es editar el fichero #**/etc/php/7.3/fpm/pool.d/www.conf** y debajo de listen = /run/php/php7.3-fpm.sock añadimos listen= 192.168.3.6:9000 en mi caso y reiniciamos el servicio fpm.*

![14º imagen](image-1.png)

![15º imagen](image-2.png)

*El 2º paso es crear el árbol de directorios #**/var/wwww/html** en el servidor nfs y descargar WordPress en los servidores y descomprimirlo en los servidores web 1 y web 2 y nfs.*

![16º imagen](<practica capa 3 balanceadores/serverweb1/descarga wordpress.png>)

![17º imagen](<practica capa 3 balanceadores/serverweb1/descomprimir carpeta serverweb1.png>)

![18º imagen](<practica capa 3 balanceadores/serverweb2/descargar wordpress serverweb2.png>)

![19º imagen](<practica capa 3 balanceadores/serverweb2/descomprimir wordpress serverweb2.png>)

![20º imagen](<practica capa 3 balanceadores/servernfsymotorphp/captura 1 crear arbol de directorios .png>)

![21º imagen](image-3.png)

![22º imagen](image-4.png)

![23º imagen](image-5.png)

*El 3º paso es cambiar en el servidor nfs los permisos sobre la carpeta que vamos a compartir #**/var/www/wordpress** y lo cambiaremos a nobody:nogroup para que los servidores web 1 y 2 puedan crear archivos o cambios en algún fichero y se reflejen esos cambios en el servidor nfs.*

![24º imagen](<practica capa 3 balanceadores/servernfsymotorphp/cambiar propietario a nobody nogroup .png>)


* El 4º paso es editar el fichero /ect/exports para decirle al servidor nfs que carpeta queremos compartir y que clientes pondran montarlas también diremos una serie de directivas como rw permisos de escritura y lectura sync para sincronizar los cambios y no subtree_check es una opción que acepta la manera en el que el sistema maneja las solicitudes de acceso sobre un recurso compartido de nfs exportado pondremos las ip de los servidores web 1 y web 2 y la carpeta que vamos a compartir es #var/www/wordpress como se ve a continuación.*

![25º imagen](<practica capa 3 balanceadores/servernfsymotorphp/editar fichero en etc exports.png>)


*El 5º paso es montar las carpetas con el comando mount en los servidores web para eso necesitamos la ip del servidornfs:carpetacompartida carpeta donde se va a montar que es en #/var/wwww/wordpress como vemos a continuación y comprobamos con #df -h que se ha montado correctamente.*

![26º imagen](<practica capa 3 balanceadores/servernfsymotorphp/montar en serverweb1 la carpeta y comprobar que se ha montado.png>)

![27º imagen](<practica capa 3 balanceadores/servernfsymotorphp/montar carpeta y comprobar que se ha montado serverweb2.png>)

## CONFIGURACIÓN DEL BALANCEAODR DE MYSQL Y GALERA EN LOS SERVIDORES DE DATOS 1 Y 2 ##

*2º paso es para el servicio mysql en los 3 servidores de seguido editamos el fichero #/etc/mysql/mariadb.conf.d/50-server.cnf y poner las cláusulas para hacer un clúster de base de datos en los 3 servidores se llamara en los 3 con el mismo nombre indicaremos la ip en los 3 servidores en el apartado wsrep_cluster-address y en wsrep_node_address pondremos en cada uno su ip propia no la de los otros servidores y el bin address será 0.0.0.0 en todos los servidores.*

![28º imagen](<practica capa 3 balanceadores/balanceadormysql/cluster base de datos .png>)

![29º imagen](<practica capa 3 balanceadores/serverdatos1/detener servicio mysql datos1.png>)

![30º imagen](<practica capa 3 balanceadores/serverdatos2/detener servicio mysql.png>)

![31º imagen](<practica capa 3 balanceadores/balanceadormysql/cluster base de datos .png>)

![32º imagen](<practica capa 3 balanceadores/serverdatos1/añadir datos1 al cluster.png>)

![33º imagen](<practica capa 3 balanceadores/serverdatos2/añadir datos2 al cluster .png>)

![30º imagen](<practica capa 3 balanceadores//balanceadormysql/bin address balanceador mysql.png>)

*El 2º paso es editar el fichero /etc/haproxy/haproxy.cfg en bind pondremos la ip del servidor balanceador y en server galera-mariadb-1 la ip del balanceador el 2 la ip del server datos 1 y la 3 el server datos 2.*

![34º imagen](<practica capa 3 balanceadores/balanceadormysql/fichero haproxy para balanceador1.png>)

![35º imagen](<practica capa 3 balanceadores/balanceadormysql/haproxy2.png>)


*El 3º paso es levantar con el comando **#sudo_galera_new_cluster** y comprobamos mediante una sentencia que todo está funcionando.*

![36º imagen](<practica capa 3 balanceadores/balanceadormysql/inicar cluster .png>)

![37º imagen](<practica capa 3 balanceadores/serverdatos2/inicar servicio datos 2.png>)

![38º imagen](image-6.png)

![39º imagen](<practica capa 3 balanceadores/balanceadormysql/sentencia para comprobar que el cluster se ha realizado correctamente .png>)

*El 4º paso es crear la base de datos y el usuario para WordPress en el balanceador mysql la base de datos se llamra wp_db y el usuario se llamará josema con contraseña josema y el acceso a ese usuario será 192.168.4.% y le daremos permisos al usuario sobre esa base de datos y comprobamos que los servidores nginx acceden a la base de datos.*

![40º imagen](<practica capa 3 balanceadores/balanceadormysql/crear base de datos para wordpress.png>)

![41º imagen](<practica capa 3 balanceadores/balanceadormysql/crear usuario para toda la red .png>)

![42º imagen](<practica capa 3 balanceadores/serverweb1/funcionamiento correcto usuario y base de datos .png>)

![43º imagen](<practica capa 3 balanceadores/serverweb2/acceso correcto a el usuario con base de datos creada.png>)


## PASOS PREVIOS A LA INSTALACIÓN DE WORDPRESS ##

*Lo primero será cambiar el document root de los servidores web a **#/var/wwww/wordpress***

![44º imagen](<practica capa 3 balanceadores/serverweb1/editiar siito virtual serverweb1.png>)

![45º imagen](<practica capa 3 balanceadores/serverweb2/editar siito virtual serverweb2.png>)

*Lo segundo será renombrar el fichero wp-simple-config.php a wp-config.php y luego editaremos el fichero para indicar en dbname el nombre de la base de datos que hemos creado db user y db password el usuario y contraseña y el db host la ip del balanceador de mysql lo haremos en el servidor web 1 y se aplicara al servidor web 2 y el servidor nfs debido a que esta compartida la carpeta con nfs y renombraremos el fichero en el servidor nfs.*

![46º imagen](<practica capa 3 balanceadores/servernfsymotorphp/cambiar de nombre a archivo de configuracion de wordpress.png>)

![47º imagen](<practica capa 3 balanceadores/serverweb1/editar archivo de configuración wordpress para conectar base de datos serverweb1.png>)

## INSTALACIÓN Y PERSONALIZACIÓN DE WORDPRESS ##

*Lo primero que haremos será acceder a la ruta http://192.168.1.112:8001 y lo que nos saldrá es la página de bienvenida de WordPress.*

![48º imagen](<practica capa 3 balanceadores/balanceadorweb/ejecución wordpress .png>)


* Lo siguiente que nos saldrá es configurar WordPress indicando el nombre de la base de datos el usuario y la contraseña de la base de datos el host de la base de datos y el prefijo de las tablas para la base de datos y darle a submit.*

![49º imagen](<practica capa 3 balanceadores/balanceadorweb/configurar 1 cosa en wordpress.png>)


*Ahora nos preguntara el título del sitio el usuario y la contraseña administrador y el email y marcaremos que los navegadores indexen la página.*


![50º imagen](<practica capa 3 balanceadores//balanceadorweb/datos metidos .png>)


*Lo siguiente que se nos mostrara es que se ha creado correctamente y le damos a login in.*

![51º imagen](<practica capa 3 balanceadores/balanceadorweb/creado .png>)

*Ahora nos pregunta nuestras credenciales puestas anteriormente en el usuario y contraseña si es correcto se nos mostrara la página de administración de WordPress.*

![52º imagen](<practica capa 3 balanceadores/balanceadorweb/usuario y contraseña para acceder.png>)

![53º imagen](<practica capa 3 balanceadores/balanceadorweb/acceso completado.png>)

*Ahora le daremos al apartado Pages y add new page ahí nos saldrá una pantalla donde personalizaremos la página y le daremos a publicar y copiaremos el enlace y finalmente veremos la página creada y personalizada.*

![54º imagen](<practica capa 3 balanceadores/balanceadorweb/página personalizada wordpress.png>)

![55º imagen](<practica capa 3 balanceadores/balanceadorweb/publicar pagina wordpress.png>)

![56º imagen](<practica capa 3 balanceadores/balanceadorweb/visualización final de la página.png>)


*Con esto hemos hemos instalado wordpress satisfactoriamente en las 4 capas de servidores.*


## CONCLUSIÓN ##

*La parte mas importante de está práctica son los balanceadores si estos no funcionan nada en la práctica lo hara otra parte mas importante es el servidor nfs con el motor php si los servidores web no se conectan al motor php ni el nfs funciona el servidor dara error 502 tambien montar 4 capas para dar mas seguridad a nuesttra infraestructura.*

**Practica realizada por José Manuel Cano González**