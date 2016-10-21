double value;

void setup()
{
  Serial.begin(115200UL);
  pinMode(7, INPUT);
}

void loop()
{
  //if (analogRead(A5) > 50) {
    value = analogRead(A0);

    /********************/
     value *= 1000;
     value *= 5;
     value *= 11;
     value /= 1024;
     /********************/

    Serial.println(value);
  //}
  delayMicroseconds(100);
}
