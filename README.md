# TalismanCompiler

## Proyecto compilador C en Elixir

El compilador del equipo Talisman conformado por sus integrantes Horacio Acosta Hernandez y Alan Ulises Sánchez Bautista, ambos desarrolladores por igual de este proyecto el cual cumple con los requisitos y objetivos planteados para la semana 3 del compilador marcado por la pagina:
https://norasandler.com/2017/12/15/Write-a-Compiler-3.html
Cumpliendo asi el poder reconocer programas en lenguje c donde se realizen operacion unarias y binarias. Siendo todo esto realizado mediante el comando mix.
Con esto se puede completar el requisito instruido por el profesor Norberto, cumpliendo asi los objetivos de trabajo y aprendizaje.

## Instalación

1. Descarga el repositorio de https://github.com/hiphoox/c202-talisman y entra a la carpeta raíz 

2. Abre una terminal y ejecuta la siguiente acción para crear el compilador:
```bash
mix escript.build
```
3. Con el compilador creado puedes obtener información de los comandos disponibles utilizando:
```bash
./talisman_compiler --h
```

4. Para compilar tu programa C es necesario indicar la rutadel archivo .c que se desea utilizar, por ejemplo:
```bash
./talisman_compiler --gc examples/return_2.c
```

## Fuente

[Curso de Nora Sandler](https://norasandler.com/)

