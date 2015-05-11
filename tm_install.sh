#!/bin/bash
pwd

apt-get -y update
apt-get install -y git
apt-get install -y nodejs-legacy
apt-get install -y npm
cd root
git clone https://github.com/TeamMentor/TM_4_0_Design.git
ls
cd TM_4_0_Design
ls
npm install
npm start
