
!/bin/bash 

# Script informacion sistema

# Aqui se define la variable El comando lsb_release imprime cierta información de LSB (Linux Standard Base) y Distribución.


LSB=/usr/bin/lsb_release



# $1-> MENSAJE
# $@ =todos los parámetros////Definimos la variable local mensaje con todos los parametros

function espera(){
	local mensaje="$@"	
        [ -z $mensaje ] && { printf "**Nota: Algunos comandos necesitaran permisos de root*** \nPresione ENTER para continuar..."; }
	read -p "$mensaje" readEnterKey
}

# MENU
function Menu(){
      
    printf "\n"
    printf "< Que onda >\n"
    printf " --------------------\n"
    printf "            \  \n"
    printf "             \          __---__\n"
    printf "                    _-       /--______\n"
    printf "               __--( /     \ )XXXXXXXXXXX\v.\n"
    printf "             .-XXX(   O   O  )XXXXXXXXXXXXXXX-\n"
    printf "            /XXX(       U     )        XXXXXXX \n"
    printf "          /XXXXX(              )--_  XXXXXXXXXXX \n"
    printf "         /XXXXX/ (      O     )   XXXXXX   \XXXXX\ \n"
    printf "         XXXXXX__/          XXXXXX         \__---->\n"
    printf " ---___  XXX__/          XXXXXX      \__         /  \n"
    printf "   \-  --__/   ___/\  XXXXXX            /  ___--/=   \n"
    printf "    \-\    ___/    XXXXXX              '--- XXXXXX  \n"
    printf "        \-\/XXX\ XXXXXX                      /XXXXX \n"
    printf "         \XXXXXXXXX   \                    /XXXXX/\n"
    printf "          \XXXXXX      >                 _/XXXXX/ \n"
    printf "            \XXXXX--__/              __-- XXXX/\n"
    printf "             -XXXXXXXX---------------  XXXXXX-\n"
    printf "                \XXXXXXXXXXXXXXXXXXXXXXXXXX/\n"
    printf "                  ""VXXXXXXXXXXXXXXXXXXV""\n"  
    printf "\n" 
    date
    printf " ---------------------------\n"
    printf "  INFORMACIÓN SISTEMA OPERATIVO LINUX  \n"
    printf " ---------------------------\n"
	printf "1. Informacion del S.O.\n"
	printf "2. Informacion del Hostname y DNS\n"
	printf "3. Informacion tarjeta de red\n"
	printf "4. Ultimos Reinicios y apagados del sistema\n"
	printf "5. Usuarios conectados\n"
	printf "6. Ultimos usuarios conectados\n"
	printf "7. Hora de sesion del usuario\n"
	printf "8. Informacion de la memoria\n"	
	printf "9. Salir\n"
}

# encabezado
# $1 - MENSAJE
function cabecera(){
	local h="$@"
	printf " ---------------------------------------------------------------\n"
	printf "     ${h}"
	printf " ---------------------------------------------------------------\n"
}


#op 1
# informacion del sistema operativo
# -X es la bandera para ejecutar el comando uname ----
# -a mostrar toda la informacion del s.o
function sistema_operativo(){    
     #La cantindad de ../ es la cantidad de paretas que debe devolverse
   	#-d = directorio, -f = file/archivo
   	# |tee -a archivo.txt = es para escribir la información en un archivo .tx
   	
   	
   cd /tmp	     
   if [ -d /tmp/Evidencia/ ]; then 
   cd Evidencia/
   mkdir Sistema
   cd Sistema/ 
  
    printf "\n" |tee -a sistema.txt	
     cabecera " Información del sistema \n" |tee -a sistema.txt
	 printf "Sistema operativo: $(uname) \n"|tee -a sistema.txt
	 [ -x $LSB ] && $LSB -a |tee -a sistema.txt || printf "$LSB no se puede ejecutar comando (set \$LSB)"
	 printf "\n"   |tee -a sistema.txt   
	printf "***********************\n" |tee -a sistema.txt
	printf "*** Hora del sistema***\n" |tee -a sistema.txt
	printf "***********************\n" |tee -a sistema.txt
    date |tee -a sistema.txt
    printf "\n" |tee -a sistema.txt  
	 
   else 
   mkdir Evidencia
   cd Evidencia/
   mkdir Sistema  
     cd Sistema/ 
     
    printf "\n" |tee -a sistema.txt	
     cabecera " Información del sistema \n" |tee -a sistema.txt
	 printf "Sistema operativo: $(uname) \n"|tee -a sistema.txt
	 [ -x $LSB ] && $LSB -a |tee -a sistema.txt || printf "$LSB no se puede ejecutar comando (set \$LSB)" 
	 	 printf "\n"   |tee -a sistema.txt
    	printf "***********************\n" |tee -a sistema.txt
	printf "*** Hora del sistema***\n" |tee -a sistema.txt
	printf "***********************\n" |tee -a sistema.txt
    date |tee -a sistema.txt
    printf "\n" |tee -a sistema.txt
	    fi  
    	 		
	#espera "Presione enter para continuar..."
	espera
}



#op 2
#Informacion del Hostname y DNS

function infoDNS(){

   cd /tmp	     
   if [ -d /tmp/Evidencia/ ]; then 
   cd Evidencia/
   mkdir DNS
   cd DNS/  
	local dnsips=$(sed -e '/^$/d' /etc/resolv.conf | awk '{if (tolower($1)=="nameserver") print $2}') |tee -a DNS.txt
	cabecera " Informacion del Hostname y DNS \n" |tee -a DNS.txt
	printf "Hostname : $(hostname -s)\n" |tee -a DNS.txt
	printf "Dominio : $(hostname -d)\n" |tee -a DNS.txt
	printf "Nombre de dominio completo: $(hostname -f)\n" |tee -a DNS.txt
	printf "IP :  $(hostname -i)\n" |tee -a DNS.txt
	printf "Nombre servidor (DNS IP) : ${dnsips}\n" |tee -a DNS.txt
	printf "\n" |tee -a DNS.txt
	 else 
   mkdir Evidencia
   cd Evidencia/
   mkdir DNS  
   cd DNS/
  local dnsips=$(sed -e '/^$/d' /etc/resolv.conf | awk '{if (tolower($1)=="nameserver") print $2}') |tee -a DNS.txt
	cabecera " Informacion del Hostname y DNS \n" |tee -a DNS.txt
	printf "Hostname : $(hostname -s)\n" |tee -a DNS.txt
	printf "Dominio : $(hostname -d)\n" |tee -a DNS.txt
	printf "Nombre de dominio completo: $(hostname -f)\n" |tee -a DNS.txt
	printf "IP :  $(hostname -i)\n" |tee -a DNS.txt
	printf "Nombre servidor (DNS IP) : ${dnsips}\n" |tee -a DNS.txt
	printf "\n" |tee -a DNS.txt
   fi  
   
	espera
}

#op 3
# Informacion tarjeta de red

function infored(){

    cd /tmp	     
   if [ -d /tmp/Evidencia/ ]; then 
   cd Evidencia/
   mkdir TarjetaRed
   cd TarjetaRed/  
	devices=$(netstat -i | cut -d" " -f1 | egrep -v "^Kernel|Iface|lo") |tee -a infored.txt
	cabecera " Informacion tarjeta de red \n"|tee -a infored.txt
	printf "\n"|tee -a infored.txt
	printf "Total de interfaces: $(wc -w <<<${devices}) \n"|tee -a infored.txt
	printf "\n"|tee -a infored.txt

	printf "*** IP  ***\n"|tee -a infored.txt
	ip -4 address show |tee -a infored.txt
	
    printf "\n"|tee -a infored.txt
	printf "***********************\n" |tee -a infored.txt
	printf "*** Enrutamiento de red***\n" |tee -a infored.txt
	printf "***********************\n" |tee -a infored.txt
	netstat -nr |tee -a infored.txt
	
    printf "\n" |tee -a infored.txt
 	printf "**************************************\n" |tee -a infored.txt
	printf "*** Informacion de trafico de red ***\n" |tee -a infored.txt
	printf "**************************************\n" |tee -a infored.txt
	netstat -i |tee -a infored.txt
	
	printf "\n" |tee -a infored.txt
	else 
   mkdir Evidencia
   cd Evidencia/
   mkdir TarjetaRed  
   cd TarjetaRed/
   devices=$(netstat -i | cut -d" " -f1 | egrep -v "^Kernel|Iface|lo") |tee -a infored.txt
	cabecera " Informacion tarjeta de red \n"|tee -a infored.txt
	printf "\n"|tee -a infored.txt
	printf "Total de interfaces: $(wc -w <<<${devices}) \n"|tee -a infored.txt
	printf "\n"|tee -a infored.txt

	printf "*** IP  ***\n"|tee -a infored.txt
	ip -4 address show |tee -a infored.txt
	
    printf "\n"|tee -a infored.txt
	printf "***********************\n" |tee -a infored.txt
	printf "*** Enrutamiento de red***\n" |tee -a infored.txt
	printf "***********************\n" |tee -a infored.txt
	netstat -nr |tee -a infored.txt
	
    printf "\n" |tee -a infored.txt
 	printf "**************************************\n" |tee -a infored.txt
	printf "*** Informacion de trafico de red ***\n" |tee -a infored.txt
	printf "**************************************\n" |tee -a infored.txt
	netstat -i |tee -a infored.txt
	printf "\n" |tee -a infored.txt
     fi	
	espera 
}

#op 4
#Ultimos Reinicios y apagados del sistema
function info_rein(){

    cd /tmp	     
   if [ -d /tmp/Evidencia/ ]; then 
   cd Evidencia/
   mkdir ReinicioApagado
   cd ReinicioApagado/  
	devices=$(netstat -i | cut -d" " -f1 | egrep -v "^Kernel|Iface|lo") |tee -a reiniapag.txt
	cabecera " Informacion ultimos Reinicios y apagados del sistema \n" |tee -a reiniapag.txt
	
	printf "\n" |tee -a reiniapag.txt
	printf "***********************\n" |tee -a reiniapag.txt
	printf "*** Tiempo que lleva encendido ***\n" |tee -a reiniapag.txt
	printf "***********************\n" |tee -a reiniapag.txt
	uptime -p |tee -a reiniapag.txt
	
	printf "\n" |tee -a reiniapag.txt
	printf "***********************\n" |tee -a reiniapag.txt
	printf "*** Ultimo reinicio***\n" |tee -a reiniapag.txt
	printf "***********************\n" |tee -a reiniapag.txt
	who -b |tee -a reiniapag.txt

	
	printf "\n" |tee -a reiniapag.txt
	printf "***********************\n" |tee -a reiniapag.txt
	printf "*** Ultimo(s) reinicio(s)***\n" |tee -a reiniapag.txt
	printf "***********************\n" |tee -a reiniapag.txt
	last reboot |tee -a reiniapag.txt
	
	printf "\n" |tee -a reiniapag.txt
	printf "***********************\n" |tee -a reiniapag.txt
	printf "*** Ultimo(s) apagado(s)***\n" |tee -a reiniapag.txt
	printf "***********************\n" |tee -a reiniapag.txt
	last -x shutdown |tee -a reiniapag.txt
		
	printf "\n" |tee -a reiniapag.txt
	
   else 
   mkdir Evidencia
   cd Evidencia/
   mkdir ReinicioApagado  
   cd ReinicioApagado/
   devices=$(netstat -i | cut -d" " -f1 | egrep -v "^Kernel|Iface|lo") |tee -a reiniapag.txt
	cabecera " Informacion ultimos Reinicios y apagados del sistema \n" |tee -a reiniapag.txt
	
	printf "\n" |tee -a reiniapag.txt
	printf "***********************\n" |tee -a reiniapag.txt
	printf "*** Tiempo que lleva encendido ***\n" |tee -a reiniapag.txt
	printf "***********************\n" |tee -a reiniapag.txt
	uptime -p |tee -a reiniapag.txt
	
	printf "\n" |tee -a reiniapag.txt
	printf "***********************\n" |tee -a reiniapag.txt
	printf "*** Ultimo reinicio***\n" |tee -a reiniapag.txt
	printf "***********************\n" |tee -a reiniapag.txt
	who -b |tee -a reiniapag.txt

	
	printf "\n" |tee -a reiniapag.txt
	printf "***********************\n" |tee -a reiniapag.txt
	printf "*** Ultimo(s) reinicio(s)***\n" |tee -a reiniapag.txt
	printf "***********************\n" |tee -a reiniapag.txt
	last reboot |tee -a reiniapag.txt
	
	printf "\n" |tee -a reiniapag.txt
	printf "***********************\n" |tee -a reiniapag.txt
	printf "*** Ultimo(s) apagado(s)***\n" |tee -a reiniapag.txt
	printf "***********************\n" |tee -a reiniapag.txt
	last -x shutdown |tee -a reiniapag.txt
		
	printf "\n" |tee -a reiniapag.txt
   
   fi
	espera 
}

#op 5
#Usuarios Conectados
# la variable local opcion="$1" es el argumento 
#who -H =es el comando para verificar usuuario conectado
#last =es el comando para verificar los usuarios que se loguearon

function usuarioconec(){

    cd /tmp	     
   if [ -d /tmp/Evidencia/ ]; then 
   cd Evidencia/
   mkdir usuario
   cd usuario/  
	local opcion="$1"
	case "$opcion" in 
		who) cabecera "Usuario(S) logueados \n" |tee -a conectado.txt ;  
		who -H |tee -a conectado.txt ; 
		espera ;;	 
		
		last) cabecera "Lista de los últimos usuarios registrados \n" |tee -a ultimoconectado.txt;  
		 last |tee -a ultimoconectado.txt;
		  espera ;; 
		 
	sesion) cabecera "Hora de sesion del usuario \n" |tee -a sesion.txt ;
	     w  |tee -a sesion.txt ;
	      espera ;;	
	esac 
	
	else 
   mkdir Evidencia
   cd Evidencia/
   mkdir usuario  
   cd usuario/
   	local opcion="$1"
	case "$opcion" in 
		who) cabecera "Usuario(S) logueados \n" |tee -a conectado.txt ;  
		who -H |tee -a conectado.txt ; 
		espera ;;	 
		
		last) cabecera "Lista de los últimos usuarios registrados \n" |tee -a ultimoconectado.txt;  
		 last |tee -a ultimoconectado.txt;
		  espera ;; 
		 
	sesion) cabecera "Hora de sesion del usuario \n" |tee -a sesion.txt ;
	     w  |tee -a sesion.txt ;
	      espera ;;	
	esac
	fi
	
}


#op 6
function mem_info(){

   cd /tmp	     
   if [ -d /tmp/Evidencia/ ]; then 
   cd Evidencia/
   mkdir Memoria
   cd Memoria/  
	cabecera " Memoria en uso\n" |tee -a memoria.txt
	free -m |tee -a memoria.txt
	printf "\n"     |tee -a memoria.txt
    printf "*********************************\n" |tee -a memoria.txt
	printf "*** Memoria ***\n" |tee -a memoria.txt
    printf "*********************************\n" |tee -a memoria.txt
	vmstat |tee -a memoria.txt
	printf "\n" |tee -a memoria.txt
    printf "***********************************\n" |tee -a memoria.txt
	printf "*** Procesos en ejcución top 5 ***\n" |tee -a memoria.txt
    printf "***********************************\n"	 |tee -a memoria.txt
    printf "\n"    |tee -a memoria.txt
	ps auxf | sort -nr -k 4 | head -5 	 |tee -a memoria.txt
	
	else 
   mkdir Evidencia
   cd Evidencia/
   mkdir Memoria  
   cd Memoria/
   cabecera " Memoria en uso\n" |tee -a memoria.txt
	free -m |tee -a memoria.txt
	printf "\n"     |tee -a memoria.txt
    printf "*********************************\n" |tee -a memoria.txt
	printf "*** Memoria ***\n" |tee -a memoria.txt
    printf "*********************************\n" |tee -a memoria.txt
	vmstat |tee -a memoria.txt
	printf "\n" |tee -a memoria.txt
    printf "***********************************\n" |tee -a memoria.txt
	printf "*** Procesos en ejecución top 5 ***\n" |tee -a memoria.txt
    printf "***********************************\n"	 |tee -a memoria.txt
    printf "\n"    |tee -a memoria.txt
	ps auxf | sort -nr -k 4 | head -5 	 |tee -a memoria.txt
   
   fi
	espera

}





# Entrada de teclado


function Entrada_teclado(){
	local entrada
	read -p "Presione cualquier numero del 1 al 7 de acuerdo a la opcion --> " entrada
	 printf "\n"
	case $entrada in
		1)	sistema_operativo ;;
		2)	infoDNS ;;
		3)	infored ;;
		4)	info_rein;;
		5)	usuarioconec "who" ;; #El argumento segun la opcion
		6)	usuarioconec "last" ;;
		7)	usuarioconec "sesion" ;;
		8)	mem_info ;;
		9)	 printf " _________________________________________\n"
    printf "/ Hasta la vista BABY\n"
    printf "\  \n"
    printf " -----------------------------------------\n"
    printf "        .--.\n"
    printf "       |o_o |\n"
    printf "       |:_/ |\n"
    printf "      //   \ \ \n"
    printf "     (|     | ) \n"
    printf "    /'\_   _/ \  \n"
    printf "    \___)=(___/ \n";
		
		
		 exit 0 ;;
		*)	printf "Por favor, seleccione entre 1 a 7 opción solamente \n"
		
		espera
	esac
	
}




# Ignorar CTRL+C, CTRL+Z 
trap '' SIGINT SIGQUIT SIGTSTP

# Menu 
while true
do
	clear
 	Menu	# Menu
 	Entrada_teclado # Ingreso de opcion teclado
done
