#!/bin/bash 

# Colores
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
YELLOW="\e[33m"
CYAN="\e[36m"
RESET="\e[0m"

# Comprobando que el usuario sea root
if [ $(id -u ) -ne 0 ]; then
  echo -e "${RED}Tienes que ser root para ejecutar este script${RESET}"
  exit
fi

nmapFunction(){
  # Comprobando si nmap esta instalado
  test -f /usr/bin/nmap

  if [ "$(echo $?)" == "0" ]; then
    clear

    # Banner
    echo -e "${BLUE}██╗      █████╗ ███████╗██╗   ██╗███╗   ███╗ █████╗ ██████╗ "
    echo -e "██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝████╗ ████║██╔══██╗██╔══██╗"
    echo -e "██║     ███████║  ███╔╝  ╚████╔╝ ██╔████╔██║███████║██████╔╝"
    echo -e "██║     ██╔══██║ ███╔╝    ╚██╔╝  ██║╚██╔╝██║██╔══██║██╔═══╝ "
    echo -e "███████╗██║  ██║███████╗   ██║   ██║ ╚═╝ ██║██║  ██║██║     "
    echo -e "╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ${RESET}"
   
   read -p "Introduce la ip a escanear: " ipTarget
   while true; do
     echo -e "\n${GREEN}1) Escaneo rapido pero ruidoso"
     echo -e "2) Escaneo normal"
     echo -e "3) Escaneo silencioso (Lento af)"
     echo -e "4) Escaneo de servicios y versiones"
     echo -e "5) Salir${RESET}"
     read -p "Seleccione el tipo de escaneo a ejecutar: " scan
     case $scan in 
       1) 
         clear && echo -e "${YELLOW}Escaneando ..\n${RESET}" && nmap -p- --open --min-rate 5000 -sS -n -Pn -v $ipTarget -oG allPorts && echo -e "Escaneo guardado en el fichero allPorts"
         exit
         ;;
       2)
         clear && echo -e "${YELLOW}Escaneando ..\n${RESET}" && nmap -p- --open -v $ipTarget -oG allPorts && echo -e "Escaneo guardado en el fichero allPorts"
         exit
         ;;
       3)
         clear && echo -e "${YELLOW}Escaneando ..\n${RESET}" && nmap -p- -T2 -sS -Pn -f -v $ipTarget -oG allPorts && echo -e "Escaneo guardado en el fichero allPorts"
         exit
         ;;
       4)
         clear && echo -e "${YELLOW}Escaneando ..\n${RESET}" && nmap -sCV -vvv $ipTarget -oN targeted && echo -e "Escaneo guardado en el fichero Targeted" 
         exit
         ;;
       5)
         echo -e "${RED}Saliendo... \n${RESET}"
         break
         ;;
       *)
         echo -e "${RED}No se ha encontrado el parametro, seleccione uno valido${RESET}"
         ;;
     esac
   done
  else
    # Metodos de instalacion de nmap
    echo -e "Al parecer nmap no esta instalado"
    while true; do
      echo -e "\n1) Pacman"
      echo -e "2) Apt"
      echo -e "3) Dnf"
      echo -e "4) Salir"
      read -p "\nSelecciona tu gestor de paquetes: " package
      clear
      case $package in
        1)
          echo "Instalando Nmap..." && pacman -S nmap --noconfirm > /dev/null
          ;;
        2)
          echo "Instalando Nmap..." && apt install nmap -y > /dev/null
          ;;
        3)
          echo "Instalando Nmap..." && dnf install nmap -y > /dev/null
          ;;
        4)
          echo "Saliendo..."
          sleep 2
          break
          ;;
        *)
          echo -e "Opcion invalida"
          ;;
      esac
    done
  fi
}

nmapFunction
