#!/bin/sh
ssh bgsip "cd oslab && tar -zcvf ~/lab3.tar.gz ~/oslab/lab3"
scp bgsip:~/lab3.tar.gz .
open .
