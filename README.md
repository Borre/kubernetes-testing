#Manual para ejecución de prueba de concepto SUSE CaaSP


### Repositorio de codigo:

Para bajar el repositorio de codigo de la demostración es necesario hacerlo desde el siguiente repositorio:

	https://github.com/Borre/kubernetes-testing
	
se realiza por medio del comando

	git clone https://github.com/Borre/kubernetes-testing

Una vez abajo el repositorio de codigo, ya se puede realizar la demostración de kubernetes con base en la siguiente estructura de archivos:

	- app.py - Applicación python
	- caasp-test.yaml - Archivo de configuración y despliegue para kubernetes
	- delete_script.sh - Archivo para destruir el deployment completo
	- Dockerfile - Archivo que construye el container que correr en kubernetes
	- Readme.md - Este archivo de text

### Docker Registry para el contenedor:

El contenido del contenedor descrito en el paso anterior se encuentra en el registro publico de Docker, es buena idea mostrarle al cliente este repositorio de containers y explicarle comó funciona (que desde aquí se pueden descargar diferentes tipos de S.O., etc).

	https://hub.docker.com/r/borre/test-kubernetes/

### Ejecutar "build" del contenedor en Docker

*Este paso no es necesario para desplegar el applicativo en kubernetes, es solo para fines demostrativos del container. Para este paso es necesario tener instalado docker en el equipo local donde se corran los siguientes comandos*

En el directorio donde se descargo previamente el repositorio ejecutar el siguiente comando:

	docker build -t test-kubernetes .
	
Con este comando podemos demostrar al cliente como compilar un contenedor.

### Desplegar contenedor en kubernetes

Desplegar el deployment del applicativo es bastante siempre, basta con ejecutar el siguiente comando:

	kubectl create -f caasp-test.yaml
	
Esto nos va a crear 2 servicios, uno para la base de datos de Redis y otro para la aplicación hecha en python y empaquetada en opensuse, podemos ver los despliegues ejecutando el siguiente comando:

	kubectl get pods
	
y podemos ver los balanceadores de carga con el siguiente comando:

	kubectl get services
	
Este ultimo comando nos va a devolver los puertos por los cuales estan expuestos los sevicios de kubernetes (si leemos el archivo de configuración tambien podemos ver los puertos por los cuales funciona la solución).


### Ejecutar prueba de carga a applicativo

El comando de *kubectl get services* nos va a dar el puerto por el cual esta expuesto el servicio, lo que se tiene que realizar aquí es utilizar *siege* para estresar el aplicativo y ver el autoscalamiento, esto lo realizamos de la siguiente manera:

	siege -c 60 -t 1h aquí-va-la-ip:y-aqui-el-puerto
	
Este comando va a ejecutar una carga simulando 60 usuarios concurrentes durante una hora (nota: no esperar a que termine de ejecutarse, para el proceso cuando se llege al maximo de pods creados en el dashboard de kubernetes).

Esta carga se puede ver direcamente en el dashboard de kubernetes.