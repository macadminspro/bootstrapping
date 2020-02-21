
## Bootstrappr

Una herramienta básica para instalar un conjunto de paquetes y scripts en un volumen de destino.
Por lo general, estos serían paquetes o scripts que "inscriben" la máquina en su sistema de administración; Al reiniciar, estas herramientas tomarían el control y continuarían con la instalación y configuración de la máquina.

Bootstrap está diseñado para poder ejecutarse en modo de recuperación, permitiéndole "arrancar" una máquina recién sacada de la caja sin tener que ejecutar el Asistente de configuración, creando manualmente una cuenta local y otras tareas manuales poco confiables.

### Packages

Agregar los paquetes deseados en la carpeta `bootstrap/packages`. Asegúrese de que todos los paquetes que agregue puedan instalarse correctamente en volúmenes que no sean el volumen de arranque actual.

Si sus paquetes solo tienen cargas útiles, deberían funcionar bien. Las secuencias de comandos previas y posteriores a la instalación deben verificarse para no utilizar rutas absolutas al volumen de inicio actual. El sistema instalador pasa el volumen de destino en el tercer argumento `$ 3` a los scripts de instalación.

### Scripts

Bootstrappr chequeará que los nombres de los archivos de script terminen en la extensión `.sh` y que sean ejecutables. Otros archivos serán ignorados.

Bootstrappr pasa el volumen seleccionado en el _primero_ argumento `$ 1` a los scripts. (Esto es diferente de los scripts de instalación en paquetes).

Tenga en cuenta que el sistema de recuperación no tiene el mismo conjunto de herramientas disponibles que el macOS completo tiene. `Python`, `ruby`, `zsh`, `osascript`, `systemsetup`, `networksetup` y muchos otros * no * están disponibles en el sistema de recuperación, escriba sus scripts en consecuencia usando `bash` para sus scripts es la opción más segura.

En caso de duda, inicie el Recovery y pruebe, aunque personalmente uso Internet Recovery

### Orden

Bootstrappr funcionará a través de scripts y paquetes en orden alfanumérico. Para controlar el orden, puede anteponer nombres de archivo con números.

#### iMac Pro y Mac 2018 a superior

Bootstrappr es particularmente útil con el nuevo iMac Pro y modelos más actuales de iMac, MacBook Pro, que no son compatibles con NetBoot, y es difícil de arrancar desde medios externos. Para configurar una nueva máquina, preferiría sacar la máquina de la caja, iniciar en Recuperación (Comando-R al inicio) y montar el disco Bootstrappr y ejecutar Bootstappr.

### Escenarios de uso

#### Escenario #1: disco externo USB

* Preparación:
  * Copie su
  * Copie el contenido del directorio de arranque en una unidad USB.
* Bootstrapping:
  * (Optional) Iniciar en Modo Recovery o Internet Recovery.
  * Conecte la memoria USB.
  * Abra Terminal (desde el menú Utilidades del Recovery).
  * `/Volumes/VOLUME_NAME/run` (use `sudo` si no está en Recovery)
  * Si está en Recovery, reinicie.

#### Escenario #2: Disk image via HTTP o NFS

* Preparación:
  * Cree una imagen de disco usando el script `make_dmg.sh`.
  * Copie la imagen del disco a un servidor web o NFS.
  * (Las URL seguras https pueden ser problemáticas en el modo de Recovery. las URL http deberían estar bien.)
* Bootstrapping:
  * (Opcional) Inicie en modo Recovery.
  * Abra Terminal (desde el menú Utilidades del Recovery).
  * `hdiutil attach <tu_bootstrap_dmg_url>`
  * Usando un servidor NFS ejecute lo siguiente:
  * mkdir /Volumes/
  * `/Volumes/bootstrap/run` (use `sudo` si no está en Recovery)
  * Si está en Recovery, reinicie.


### Sesión de muestra

```
# hdiutil attach http://macbootstrap
/dev/disk3          	GUID_partition_scheme          	
/dev/disk3s1        	Apple_HFS                      	/Volumes/bootstrap
# /Volumes/bootstrap/run 
*** Bienvenido a bootstrappr! ***
Volumes disponibles:
    1  Macintosh HD
    2  Volumen destino
    3  bootstrap
Instalar en el volumen # (1-3): 2

Instalando paquetes en /Volumes/Volumen destino...
installer: Package name is foo
installer: Installing at base path /Volumes/Volumen destino
installer: The install was successful.
installer: Package name is bar
installer: Installing at base path /Volumes/Volumen destino
installer: The install was successful.
installer: Package name is baz
installer: Installing at base path /Volumes/Volumen destino
installer: The install was successful.
installer: Package name is Munki - Managed software installation for OS X
installer: Installing at base path /Volumes/Volumen destino
installer: The install was successful.

Paquetes instalados. Y ahora?
    1  Reiniciar
    2  Apagar
    3  Salir
Escoja una opcion # (1-3): 3
```

## Licencia

## Traduccion al castellano de la obra original de Greg Neagle https://github.com/munki/bootstrappr

