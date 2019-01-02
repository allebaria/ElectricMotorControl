
long m1,m2; //Store time in interrupts
float speed;//Sepeed calculation
long t_tot=0;//Mean value of interrupts
long up_times[3]={9999,9999,9999};//Interrupts timing
int index=0; //Intex for interrupts timing
int pin = 2; // Encoder pin
int PWM = 3; //PWM pin
float pol[5] = {2.37556384915997e-06,  -0.000890471445004078, 0.126572231958644, -7.42301501605368,210.053539419363};
float v;
int x = 75;
int cont = 0;
int i = 0;
int iant = 0;
//Interrupt for encoder
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

  //i=micros();
//
//  iant=i;
  cont++;
  if (cont == 400){
    x=120;
  }else if(cont == 800){
    x = 75;
    cont=0;
  }
  
  v = x*(x*(x*(x*pol[0]+pol[1])+pol[2])+pol[3])+pol[4];
  analogWrite(PWM,v); //set pwm
  //to allow the ,motor to stabilize
  long t_min=up_times[0]+up_times[1]+up_times[2];
  speed=60E6/t_min/30; //Compute speed
  Serial.print(x);
  Serial.print(",");
  Serial.println(speed); //print speed
}
