# [eolica](http://instagram.com/_eolica_)
Code Repo for IAAC's LLUM 2020 instalation titled ["Eolica"](http://instagram.com/_eolica_)
Instagram: [http://instagram.com/_eolica_](http://instagram.com/_eolica_)

# Hardware

The installation takes input from 8 custom fabricated pinwheels with embedded IR sensors. Four pinwheels are connected to one Arduino MKR1000 for a total of two MKR1000 nodes. These are connected to a local WIFI AP.  

The Arduino code takes advantage of the MKR1000 four ISR enabled digital input pins for reading the RPMs of the pinwheels. This data is broadcast via UDP/OSC and received to a computer running Processing and Max/MSP.

## Software
- Arduino IDE
- Arduino WIFI101 Library
- CNMAT OSC Library https://github.com/CNMAT/OSC
- Arduino sketch based on the "ConnectWPA.ino" WIFI101 example by Tom Igoe
- Processing IDE
- oscP5 Library by andreas schlegel, http://www.sojamo.de/oscP5
- Processing sketch based on the oscP5 sample "oscP5sendReceive.pde"
- Resolume Arena
- Max/MSP

## Hardware
- Arduino MKR1000 (x2)
- Pinwheels

# Credits
"Eolica" installation was developed by the 18-20 MAA02 students at the [Institute for Advanced Architecture of Catalonia](https://iaac.net) in Barcelona. The project was developed from October 2019 through February 2020 and presented at the LLUMBCN 2020 Festival February 14-16, 2020. 

Project funding provided by the Institut de Cultura de Barcelona.

## Physical Computing
Surayyn Selvan, Anton Koshelev, Ivan Marchuk, Yimeng Wei, Ankita Alessandra Bob, Aysel Abasova, Manan Jain

## Interactive Systems
Doruk Yildirim, Tolga Kalcioglu, Timothy Lam, Yigitalp Behram, Oana Taut Hongyu Wang

## Design
Kristine Kuprijanova, Megan Yates Smylie, Pratik Girish Borse, Aishath Nadh Ha Naseer

## Communication
Daria Ciobanu-Enescu, Eszter Olah, Logesh Mahalingam, Holly Victoria Carton, Hena Micoogullari


## Logistics
Fiona Demeur, Haresh Ragunathan

## Direction
[Cristian Rizzuti](http://www.cristianrizzuti.com/) and [Luis E. Fraguada](https://github.com/fraguada)

## Academic Coordination
Marco Ingrassia