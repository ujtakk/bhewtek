void setup()
{
  Serial.begin(115200UL);
}

void loop()
{
  double value = analogRead(A0);

  value *= 1000;
  value *= 5;
  value *= 11;
  value /= 1024;

  Serial.println(value, 4);
  //Serial.println(" [mV]");
  delay(5);
}
