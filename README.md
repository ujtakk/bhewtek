# Convolutional Neural Network Engine

bhewtek
├── README.md
├── (zedboard)
      * ZedBoard用のワークディレクトリ．
├── (cpp)
      * C++でのシミュレーション環境
        /home/takau/git/conv_src.git を参照されたい
├── doc
      * 初期段階の仕様書など
├── data
      * 論理シミュレーションの入力や重みを保存しているディレクトリ
        プロジェクトルートでmakeを叩くと/home/work/takau/bhewtekからrsyncで取ってくる
├── rtl
      * RTL記述のワークディレクトリ．ユーザーロジックの最上位モジュールはtop.v.erb
├── saif_rtl
      * SAIF(信号遷移データ)データの収集用ディレクトリ．下記の注意参照.
├── scripts
      * 補助的なスクリプトを保存
├── syn
      * 論理合成のワークディレクトリ．ASIC環境での電力解析もここで行う．
└── vivado
      * FPGA用の論理合成環境，論理合成までのプロトタイピング向け

-----------------------------------

*NOTICE*

saif_rtlフォルダで、SAIFデータの収集を行う際には事前に
rtlフォルダのparameters.rbの変数$projectをリポジトリの絶対パスに指定しなおしてください。

bhewtek is nonsense.
