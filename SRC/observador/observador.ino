long m1,m2; //Store time in interrupts
float pol[5] = {2.37556384915997e-06,  -0.000890471445004078, 0.126572231958644, -7.42301501605368,210.053539419363};
int pin = 2; // Encoder pin
int index=0; //Intex for interrupts timing
long up_times[3]={9999,9999,9999};//Interrupts timing
long t_tot=0;//Mean value of interrupts

float Ad[2][2] = {{0.5085,0.2},{-0.1075, 0.9954}};
float Bd[2] = {0.0131, 0.1185};

int Csensor[2] = {1, 0};

float Nx[2]={1,2.3914};
float Nu=1.0003;


float k1d=-0.6271 ;
float k2d=2.7978;
float Ld[2] = {1.0924, 3.0098};

float uk=0;
float xk=0;
float xek1[2]={0,0};
float x=75;
float ref;
int cont=0;
int h=50;
int PWMport=3; //PWM
float xek[2] = {0, 0};
float iant = 0;



void int0()
{
  m1=micros();
  up_times[index]=m1-m2;
  index=(index+1)%3;
  m2=m1;
}

void setup() {
  pinMode(pin, INPUT);
  digitalWrite(pin,HIGH);
  attachInterrupt(digitalPinToInterrupt(pin), int0, RISING);
  //Initialize serial and wait for port to open:
  Serial.begin(115200);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB
  }
}

void loop() {
  Serial.print("---------------------------------------");
  Serial.print(",");
//  float i=micros();
//  Serial.print(i);
//  Serial.print(",");
  //iant=i;
  cont++;
  if (cont == 400){
    x=120;
  }else if(cont == 800){
    x = 75;
    cont=0;
  }
  //ref = x*(x*(x*(x*pol[0]+pol[1])+pol[2])+pol[3])+pol[4];
  ref=x;
  long t_min=up_times[0]+up_times[1]+up_times[2];
  xk=60E6/t_min/30; //Compute speed
  uk=(ref*Nu)+(-k1d*(xek[0]-Nx[0]*ref)-k2d*(xek[1]-Nx[1]*ref));
  if(uk>160) {uk=160;}
  else if(uk<62) {uk=62;}
  xek1[0]=(uk*Bd[0])+(xk-(xek[0]*Csensor[0]+xek[1]*Csensor[1]))*Ld[0]+(xek[0]*Ad[0][0]+xek[1]*Ad[0][1]);
  xek1[1]=(uk*Bd[1])+(xk-(xek[0]*Csensor[0]+xek[1]*Csensor[1]))*Ld[1]+(xek[0]*Ad[1][0]+xek[1]*Ad[1][1]);
  float vUk = uk*(uk*(uk*(uk*pol[0]+pol[1])+pol[2])+pol[3])+pol[4];
  analogWrite(PWMport,vUk);
  //Next code is to use serial data and  arduino software to monitor the system
  Serial.print(xk);
  Serial.print(',');
  Serial.println(ref);
  

  xek[0]=xek1[0];
  xek[1]=xek1[1];

  
  

}

