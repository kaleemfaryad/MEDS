#include<stdio.h>
#include<stdint.h>

typedef struct{

uint32_t control;

uint32_t status;

uint32_t tx_data;

uint32_t rx_data;

}uart_t;

void uart_putchar(
uart_t *uart,
char c){

uart->tx_data=c;

printf("%c",
(char)uart->tx_data);

}

char uart_getchar(
uart_t *uart){

return
(char)uart->rx_data;

}

int main(){

uart_t uart={0};

uart_putchar(
&uart,
'A');

uart.rx_data='B';

printf("\nRX=%c\n",
uart_getchar(&uart));

}
