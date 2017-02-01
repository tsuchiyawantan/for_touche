/*
 * Touche for Arduino
 * Vidualization Example 04
 *
 */
 
float recVoltageMax;
float recTimeMax;
float voltageMax; //電圧の最大値
float timeMax; //電圧が最大値だったときの時間
 
void setup() {
  //画面サイズ
  size(800, 600); 
  // ポートを設定
  // PortSelected=5; 
  // シリアルポートを初期化
  // SerialPortSetup();
}
 
void draw() {
  
}
 
//マウスをクリック
void mouseReleased() {
  //現在の最大値を記録
  recVoltageMax = voltageMax;
  recTimeMax = timeMax;
}
 
void stop() {
  //myPort.stop();
  //super.stop();
}