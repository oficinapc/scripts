# Script Terminal Mikrotik
# Autor : Fernando Fortes
# Verifica o host de saida com ping 
# troca o gateway do link caso necessário
# versao 1.0 03-03-2020
{
 :local rmark "WAN1"
 :local count [/ip route print count-only where comment="WAN1-TESTE"]
 :if ($bound=1) do={
     :if ($count = 0) do={
         /ip route add dst-address=8.8.4.4 gateway=$"gateway-address" comment="WAN1-TESTE"
     } else={
         :if ($count = 1) do={
             :local test [/ip route find where comment="WAN1-TESTE"]
             :if ([/ip route get $test gateway] != $"gateway-address") do={
                 /ip route set $test gateway=$"gateway-address"
             }
 	} else={
            :error "Multiple routes found"
        }
      }
   } else={
       /ip route remove [find comment="WAN1-TESTE"]
   }
}

# Netwatch - usar no Down
# /log error "NET Caiu . . ."
# /ip dhcp-cl set add-def=no [find comment="NET"]  
# /tool e-mail send to="incidentes@dominio.com.br" subject="O Link do LINK-NET Caiu - Abrir chamado" body="O Link NET-EMBRATEL Caiu... "

# Usar no UP
# /log error "NET Voltou . . ."
# /ip dhcp-cl set add-def=yes [find comment="NET"]  
# /tool e-mail send to="incidentes@dominio.com.br" subject="O Link do LINK-NET Voltou - Encerrar chamado" body="O Link NET_EMBRATEL Voltou... "



