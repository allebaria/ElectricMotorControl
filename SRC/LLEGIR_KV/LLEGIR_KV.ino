int PWM=3;/*connected to Arduino's port 3(output pwm)*/
int IN2=2;/*Encoder reading*/
int pulseBlength=0;//encoder pulse length in microseconds
void setup()
{
pinMode(PWM,OUTPUT);
pinMode(IN2, INPUT);/* set pin to input*/
digitalWrite(IN2, HIGH);/* turn on pullup resistors*/
analogWrite(PWM,0);/*Start the Motor*/
Serial.begin(115200);
Serial.println("Starting data acquisition...");
}
void loop()
{
pulseBlength=pulseIn(IN2,HIGH);
Serial.println(pulseBlength);
}
