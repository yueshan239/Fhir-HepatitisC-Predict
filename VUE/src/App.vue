<template>
  <el-container>
    <el-container>

      <el-aside width="50%">
        <el-header style="display: flex;justify-content: start;">{{ title }}</el-header>
        <div class="index">
          <div style="position: relative;right: 60px;">
            <span style="width: 50px;text-align: left;position: relative;left: 5px;">Sex:</span>
            <el-select v-model="value" placeholder="Please select gender" style="width: 200px;margin-left: 25px;">
              <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value">
              </el-option>
            </el-select>
          </div>

          <div class="block" style="position: relative;right: 150px;">
            <span class="demonstration">Birthday:&nbsp;&nbsp;</span>
            <el-date-picker v-model="Birthday" type="date" placeholder="Select date of birth" style="width: 200px;">
            </el-date-picker>
          </div>
        </div>

        <div style="padding-left: 50px;display: flex;">
          <div>
            <div style="display: flex;">
              <span style="width: 50px;text-align: left;">ALB:</span><el-input style="width: 200px;" type="number"
                v-model="ALB" :clearable="true" placeholder="Please enter ALB"></el-input>
            </div>

            <div style="display: flex;">
              <span style="width: 50px;text-align: left;">ALP:</span><el-input style="width: 200px;" type="number"
                v-model="ALP" :clearable="true" placeholder="Please enter ALP"></el-input>
            </div>

            <div style="display: flex;">
              <span style="width: 50px;text-align: left;">ALT:</span><el-input style="width: 200px;" type="number"
                v-model="ALT" :clearable="true" placeholder="Please enter ALT"></el-input>
            </div>

            <div style="display: flex;">
              <span style="width: 50px;text-align: left;">AST:</span><el-input style="width: 200px;" type="number"
                v-model="AST" :clearable="true" placeholder="Please enter AST"></el-input>
            </div>

            <div style="display: flex;">
              <span style="width: 50px;text-align: left;">BIL:</span><el-input style="width: 200px;" type="number"
                v-model="BIL" :clearable="true" placeholder="Please enter BIL"></el-input>
            </div>
          </div>

          <div style="margin-left: 120px;">
            <div style="display: flex;">
              <span style="width: 77px;text-align: left;">CHE:</span><el-input style="width: 200px;" type="number"
                v-model="CHE" :clearable="true" placeholder="Please enter CHE"></el-input>
            </div>

            <div style="display: flex;">
              <span style="width: 77px;text-align: left;">CHOL:</span><el-input style="width: 200px;" type="number"
                v-model="CHOL" :clearable="true" placeholder="Please enter CHOL"></el-input>
            </div>

            <div style="display: flex;">
              <span style="width: 77px;text-align: left;">CREA:</span><el-input style="width: 200px;" type="number"
                v-model="CREA" :clearable="true" placeholder="Please enter CREA"></el-input>
            </div>

            <div style="display: flex;">
              <span style="width: 77px;text-align: left;">GGT:</span><el-input style="width: 200px;" type="number"
                v-model="GGT" :clearable="true" placeholder="Please enter GGT"></el-input>
            </div>

            <div style="display: flex;">
              <span style="width: 77px;text-align: left;">PROT:</span><el-input style="width: 200px;" type="number"
                v-model="PROT" :clearable="true" placeholder="Please enter PROT"></el-input>
            </div>
          </div>
        </div>

        <el-row
          style="display: flex; justify-content: space-between; padding-bottom: 10px; padding-top: 50px;align-items: end;width: 80%;">
          <el-button type="primary" @click="initialization" round>initialization</el-button>
          <el-button type="primary" @click="show" round>show</el-button>
          <el-button type="primary" @click="prediction" round>prediction</el-button>
        </el-row>
      </el-aside>
      <el-main>
        <div style="display: flex;margin-top: 5px;">
          <span style="width: 50px;text-align: left;">ALB:</span>
          <el-badge :value="ALB1" class="item" type="info">
            <div style="width: 100px;background-color: red;height: 30px;opacity: 30%;">
              <div style="position: relative; top: 15px; font-size: 10px;">Low</div>
            </div>
          </el-badge>
          &nbsp;&nbsp;
          <el-badge :value="ALB2" class="item" type="info">
            <div style="width: 200px;background-color: red;height: 30px;opacity: 60%;">
              <div style="position: relative; top: 15px; font-size: 10px;">normal&nbsp;35-50g/L</div>
            </div>
          </el-badge>
          &nbsp;&nbsp;
          <el-badge :value="ALB3" class="item" type="info">
            <div style="width: 150px;background-color: red;height: 30px;opacity: 90%;">
              <div style="position: relative; top: 15px; font-size: 10px;">high</div>
            </div>
          </el-badge>
          <div style="width: 10px;background-color: red;height: 30px;opacity: 90%;
            clip-path: polygon(0 0, 100% 50%, 0 100%); position: relative;left: -0.3px;">
          </div>
        </div>

        <div style="display: flex;margin-top: 5px;">
          <span style="width: 50px;text-align: left;">ALP:</span>
          <el-badge :value="ALP1" class="item" type="info">
            <div style="width: 100px;background-color: skyblue;height: 30px;opacity: 30%;">
              <div style="position: relative; top: 15px; font-size: 10px;">Low</div>
            </div>
          </el-badge>
          &nbsp;&nbsp;
          <el-badge :value="ALP2" class="item" type="info">
            <div style="width: 200px;background-color: skyblue;height: 30px;opacity: 60%;">
              <div style="position: relative; top: 15px; font-size: 10px;">normal&nbsp;40-150U/L</div>
            </div>
          </el-badge>
          &nbsp;&nbsp;
          <el-badge :value="ALP3" class="item" type="info">
            <div style="width: 150px;background-color: skyblue;height: 30px;opacity: 90%;">
              <div style="position: relative; top: 15px; font-size: 10px;">high</div>
            </div>
          </el-badge>
          <div style="width: 10px;background-color: skyblue;height: 30px;opacity: 90%;
            clip-path: polygon(0 0, 100% 50%, 0 100%); position: relative;left: -0.3px;">
          </div>
        </div>

        <div style="display: flex;margin-top: 5px;">
          <span style="width: 50px;text-align: left;">ALT:</span>
          <el-badge :value="ALT1" class="item" type="info">
            <div style="width: 100px;background-color: pink;height: 30px;opacity: 30%;">
              <div style="position: relative; top: 15px; font-size: 10px;">normal&nbsp;0-40U/L</div>
            </div>
          </el-badge>
          &nbsp;&nbsp;
          <el-badge :value="ALT2" class="item" type="info">
            <div style="width: 200px;background-color: pink;height: 30px;opacity: 60%;">
              <div style="position: relative; top: 15px; font-size: 10px;">Low</div>
            </div>
          </el-badge>
          &nbsp;&nbsp;
          <el-badge :value="ALT3" class="item" type="info">
            <div style="width: 150px;background-color: pink;height: 30px;opacity: 90%;">
              <div style="position: relative; top: 15px; font-size: 10px;">high</div>
            </div>
          </el-badge>
          <div style="width: 10px;background-color: pink;height: 30px;opacity: 90%;
            clip-path: polygon(0 0, 100% 50%, 0 100%); position: relative;left: -0.3px;">
          </div>
        </div>

        <div style="display: flex;margin-top: 5px;">
          <span style="width: 50px;text-align: left;">AST:</span>
          <el-badge :value="AST1" class="item" type="info">
            <div style="width: 100px;background-color: purple;height: 30px;opacity: 30%;">
              <div style="position: relative; top: 15px; font-size: 10px;">normal&nbsp;0-40U/L</div>
            </div>
          </el-badge>
          &nbsp;&nbsp;
          <el-badge :value="AST2" class="item" type="info">
            <div style="width: 200px;background-color: purple;height: 30px;opacity: 60%;">
              <div style="position: relative; top: 15px; font-size: 10px;">Low</div>
            </div>
          </el-badge>
          &nbsp;&nbsp;
          <el-badge :value="AST3" class="item" type="info">
            <div style="width: 150px;background-color: purple;height: 30px;opacity: 90%;">
              <div style="position: relative; top: 15px; font-size: 10px;">high</div>
            </div>
          </el-badge>
          <div style="width: 10px;background-color: purple;height: 30px;opacity: 90%;
            clip-path: polygon(0 0, 100% 50%, 0 100%); position: relative;left: -0.3px;">
          </div>
        </div>

        <div style="display: flex;margin-top: 5px;">
          <span style="width: 50px;text-align: left;">BIL:</span>
          <el-badge :value="BIL1" class="item" type="info">
            <div style="width: 100px;background-color: plum;height: 30px;opacity: 30%;">
              <div style="position: relative; top: 15px; font-size: 10px;">Low</div>
            </div>
          </el-badge>
          &nbsp;&nbsp;
          <el-badge :value="BIL2" class="item" type="info">
            <div style="width: 200px;background-color: plum;height: 30px;opacity: 60%;">
              <div style="position: relative; top: 15px; font-size: 10px;">normal&nbsp;5-21μmol/L</div>
            </div>
          </el-badge>
          &nbsp;&nbsp;
          <el-badge :value="BIL3" class="item" type="info">
            <div style="width: 150px;background-color: plum;height: 30px;opacity: 90%;">
              <div style="position: relative; top: 15px; font-size: 10px;">high</div>
            </div>
          </el-badge>
          <div style="width: 10px;background-color: plum;height: 30px;opacity: 90%;
            clip-path: polygon(0 0, 100% 50%, 0 100%); position: relative;left: -0.3px;">
          </div>
        </div>

        <div style="display: flex;margin-top: 5px;">
          <span style="width: 50px;text-align: left;">CHE:</span>
          <el-badge :value="CHE1" class="item" type="info">
            <div style="width: 100px;background-color: yellow;height: 30px;opacity: 30%;">
              <div style="position: relative; top: 15px; font-size: 10px;">Low</div>
            </div>
          </el-badge>
          &nbsp;&nbsp;
          <el-badge :value="CHE2" class="item" type="info">
            <div style="width: 200px;background-color: yellow;height: 30px;opacity: 60%;">
              <div style="position: relative; top: 15px; font-size: 10px;">normal&nbsp;4.3-10.5U/L</div>
            </div>
          </el-badge>
          &nbsp;&nbsp;
          <el-badge :value="CHE3" class="item" type="info">
            <div style="width: 150px;background-color: yellow;height: 30px;opacity: 90%;">
              <div style="position: relative; top: 15px; font-size: 10px;">high</div>
            </div>
          </el-badge>
          <div style="width: 10px;background-color: yellow;height: 30px;opacity: 90%;
            clip-path: polygon(0 0, 100% 50%, 0 100%); position: relative;left: -0.3px;">
          </div>
        </div>

        <div style="display: flex;margin-top: 5px;">
          <span style="width: 50px;text-align: left;">CHOL:</span>
          <el-badge :value="CHOL1" class="item" type="info">
            <div style="width: 100px;background-color: orange;height: 30px;opacity: 30%;">
              <div style="position: relative; top: 15px; font-size: 10px;">Low</div>
            </div>
          </el-badge>
          &nbsp;&nbsp;
          <el-badge :value="CHOL2" class="item" type="info">
            <div style="width: 200px;background-color: orange;height: 30px;opacity: 60%;">
              <div style="position: relative; top: 15px; font-size: 10px;">normal&nbsp;2.83-5.18mmol/L</div>
            </div>
          </el-badge>
          &nbsp;&nbsp;
          <el-badge :value="CHOL3" class="item" type="info">
            <div style="width: 150px;background-color: orange;height: 30px;opacity: 90%;">
              <div style="position: relative; top: 15px; font-size: 10px;">high</div>
            </div>
          </el-badge>
          <div style="width: 10px;background-color: orange;height: 30px;opacity: 90%;
            clip-path: polygon(0 0, 100% 50%, 0 100%); position: relative;left: -0.3px;">
          </div>
        </div>

        <div style="display: flex;margin-top: 5px;">
          <span style="width: 50px;text-align: left;">CREA:</span>
          <el-badge :value="CREA1" class="item" type="info">
            <div style="width: 100px;background-color: orchid;height: 30px;opacity: 30%;">
              <div style="position: relative; top: 15px; font-size: 10px;">Low</div>
            </div>
          </el-badge>
          &nbsp;&nbsp;
          <el-badge :value="CREA2" class="item" type="info">
            <div style="width: 200px;background-color: orchid;height: 30px;opacity: 60%;">
              <div style="position: relative; top: 15px; font-size: 10px;">normal&nbsp;30-110umol/L</div>
            </div>
          </el-badge>
          &nbsp;&nbsp;
          <el-badge :value="CREA3" class="item" type="info">
            <div style="width: 150px;background-color: orchid;height: 30px;opacity: 90%;">
              <div style="position: relative; top: 15px; font-size: 10px;">high</div>
            </div>
          </el-badge>
          <div style="width: 10px;background-color: orchid;height: 30px;opacity: 90%;
            clip-path: polygon(0 0, 100% 50%, 0 100%); position: relative;left: -0.3px;">
          </div>
        </div>

        <div style="display: flex;margin-top: 5px;">
          <span style="width: 50px;text-align: left;">GGT:</span>
          <el-badge :value="GGT1" class="item" type="info">
            <div style="width: 100px;background-color: sandybrown;height: 30px;opacity: 30%;">
              <div style="position: relative; top: 15px; font-size: 10px;">Low</div>
            </div>
          </el-badge>
          &nbsp;&nbsp;
          <el-badge :value="GGT2" class="item" type="info">
            <div style="width: 200px;background-color: sandybrown;height: 30px;opacity: 60%;">
              <div style="position: relative; top: 15px; font-size: 10px;">normal&nbsp;30-110umol/L</div>
            </div>
          </el-badge>
          &nbsp;&nbsp;
          <el-badge :value="GGT3" class="item" type="info">
            <div style="width: 150px;background-color: sandybrown;height: 30px;opacity: 90%;">
              <div style="position: relative; top: 15px; font-size: 10px;">high</div>
            </div>
          </el-badge>
          <div style="width: 10px;background-color: sandybrown;height: 30px;opacity: 90%;
            clip-path: polygon(0 0, 100% 50%, 0 100%); position: relative;left: -0.3px;">
          </div>
        </div>

        <div style="display: flex;margin-top: 5px;">
          <span style="width: 50px;text-align: left;">PROT:</span>
          <el-badge :value="PROT1" class="item" type="info">
            <div style="width: 100px;background-color: brown;height: 30px;opacity: 30%;">
              <div style="position: relative; top: 15px; font-size: 10px;">Low</div>
            </div>
          </el-badge>
          &nbsp;&nbsp;
          <el-badge :value="PROT2" class="item" type="info">
            <div style="width: 200px;background-color: brown;height: 30px;opacity: 60%;">
              <div style="position: relative; top: 15px; font-size: 10px;">normal&nbsp;30-110umol/L</div>
            </div>
          </el-badge>
          &nbsp;&nbsp;
          <el-badge :value="PROT3" class="item" type="info">
            <div style="width: 150px;background-color: brown;height: 30px;opacity: 90%;">
              <div style="position: relative; top: 15px; font-size: 10px;">high</div>
            </div>
          </el-badge>
          <div style="width: 10px;background-color: brown;height: 30px;opacity: 90%;
            clip-path: polygon(0 0, 100% 50%, 0 100%); position: relative;left: -0.3px;">
          </div>
        </div>
        <div class="main">
          <div style="display: flex;justify-content: start;font-size: 26px;">Forecast results</div>
          <div style="font-size: 30px;position: relative;right: 30%;padding-top: 20px;">{{ result }}</div>
        </div>
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
import axios from 'axios'
export default {
  name: 'App',
  data() {
    return {
      title: 'Hepatitis C prediction',
      Sex: '',
      Birthday: '',
      ALB: '',
      ALP: '',
      ALT: '',
      AST: '',
      BIL: '',
      CHE: '',
      CHOL: '',
      CREA: '',
      GGT: '',
      PROT: '',
      options: [{
        value: 'female',
        label: 'F'
      }, {
        value: 'male',
        label: 'M'
      }],
      value: '',
      value1: '',
      input: '',
      time: '',
      age: '',
      ALB1: '',
      ALP1: '',
      ALT1: '',
      AST1: '',
      BIL1: '',
      CHE1: '',
      CHOL1: '',
      CREA1: '',
      GGT1: '',
      PROT1: '',
      ALB2: '',
      ALP2: '',
      ALT2: '',
      AST2: '',
      BIL2: '',
      CHE2: '',
      CHOL2: '',
      CREA2: '',
      GGT2: '',
      PROT2: '',
      ALB3: '',
      ALP3: '',
      ALT3: '',
      AST3: '',
      BIL3: '',
      CHE3: '',
      CHOL3: '',
      CREA3: '',
      GGT3: '',
      PROT3: '',
      result: '',
      msg: '',
      num: 0
    }
  },
  methods: {
    show() {
      const time = Date.now()
      const birth = new Date(this.Birthday).getTime()
      const millisecondsPerYear = 24 * 60 * 60 * 1000 * 365.25;
      const ageInMilliseconds = time - birth;
      const age = Math.floor(ageInMilliseconds / millisecondsPerYear);
      this.age = age
      let date = new Date(this.Birthday)
      let year = date.getFullYear()
      let month = (date.getMonth() + 1).toString().padStart(2, '0');
      let day = date.getDate().toString().padStart(2, '0');
      this.time = `${year}-${month}-${day}`
      console.log(this.time);
      this.determine()
      console.log(this.Sex);
      // this.result = '检测结果为高风险'
      console.log(this.value);

    },
    prediction() {
      if (this.Birthday == '' || this.value == '' || this.ALB == '' || this.ALP == '' || this.ALT == '' || this.AST == '' || this.BIL == '' || this.CHE == '' || this.CHOL == '' || this.CREA == '' || this.GGT == '' || this.PROT == '') {
        this.num = 0
      } else {
        this.num = 1
      }


      if (this.num == 0) {
        this.$message({
          message: 'Please make a prediction after completing the input!',
          type: 'warning'
        });
      } else {
        axios.post("//192.168.1.5:52773/fhir/demo/PredictiveInfo", {
          Birthday: this.Birthday,
          Gender: this.value,
          ALB: this.ALB,
          ALP: this.ALP,
          ALT: this.ALT,
          AST: this.AST,
          BIL: this.BIL,
          CHE: this.CHE,
          CHOL: this.CHOL,
          CREA: this.CREA,
          GGT: this.GGT,
          PROT: this.PROT
        }).then(res => {
          console.log(res.data);
          this.result = res.data.data.GHCodeText
        })
      }

    },
    initialization() {
      axios.post("//192.168.1.5:52773/fhir/demo/Initialization", {}).then(res => {
        console.log(res.data);
        const loading = this.$loading({
          lock: true,
          text: 'Loading',
          spinner: 'el-icon-loading',
          background: 'rgba(0, 0, 0, 0.7)'
        });
        if (res.data.code === 200) {
          loading.close();
          this.msg = res.data.msg

          this.$message({
            message: this.msg,
            type: 'success'
          });
        } else {
          loading.close();
          this.msg = res.data.msg

          this.$message.error(this.msg);
        }


      })
    },
    determine() {
      if (this.ALB >= 35 && this.ALB <= 50) {
        this.ALB2 = this.ALB
        this.ALB1 = ''
        this.ALB3 = ''
      } else if (this.ALB < 35) {
        this.ALB1 = this.ALB
        this.ALB2 = ''
        this.ALB3 = ''
      } else {
        this.ALB3 = this.ALB
        this.ALB1 = ''
        this.ALB2 = ''
      }

      if (this.ALP >= 40 && this.ALP <= 150) {
        this.ALP2 = this.ALP
        this.ALP1 = ''
        this.ALP3 = ''
      } else if (this.ALP < 40) {
        this.ALP1 = this.ALP
        this.ALP2 = ''
        this.ALP3 = ''
      } else {
        this.ALP3 = this.ALP
        this.ALP1 = ''
        this.ALP2 = ''
      }

      if (this.ALT > 40 && this.ALT <= 80) {
        this.ALT2 = this.ALT
        this.ALT1 = ''
        this.ALT3 = ''
      } else if (this.ALT <= 40) {
        this.ALT1 = this.ALT
        this.ALT2 = ''
        this.ALT3 = ''
      } else {
        this.ALT3 = this.ALT
        this.ALT1 = ''
        this.ALT2 = ''
      }

      if (this.AST > 40 && this.AST <= 80) {
        this.AST2 = this.AST
        this.AST1 = ''
        this.AST3 = ''
      } else if (this.AST <= 40) {
        this.AST1 = this.AST
        this.AST2 = ''
        this.AST3 = ''
      } else {
        this.AST3 = this.AST
        this.AST1 = ''
        this.AST2 = ''
      }

      if (this.BIL >= 5 && this.BIL <= 21) {
        this.BIL2 = this.BIL
        this.BIL1 = ''
        this.BIL3 = ''
      } else if (this.BIL < 5) {
        this.BIL1 = this.BIL
        this.BIL2 = ''
        this.BIL3 = ''
      } else {
        this.BIL3 = this.BIL
        this.BIL1 = ''
        this.BIL2 = ''
      }

      if (this.CHE >= 4.3 && this.CHE <= 10.5) {
        this.CHE2 = this.CHE
        this.CHE1 = ''
        this.CHE3 = ''
      } else if (this.CHE < 4.3) {
        this.CHE1 = this.CHE
        this.CHE2 = ''
        this.CHE3 = ''
      } else {
        this.CHE3 = this.CHE
        this.CHE1 = ''
        this.CHE2 = ''
      }

      if (this.CHOL >= 2.83 && this.CHOL <= 5.18) {
        this.CHOL2 = this.CHOL
        this.CHOL1 = ''
        this.CHOL3 = ''
      } else if (this.CHOL < 2.83) {
        this.CHOL1 = this.CHOL
        this.CHOL2 = ''
        this.CHOL3 = ''
      } else {
        this.CHOL3 = this.CHOL
        this.CHOL1 = ''
        this.CHOL2 = ''
      }

      if (this.CREA >= 30 && this.CREA <= 110) {
        this.CREA2 = this.CREA
        this.CREA1 = ''
        this.CREA3 = ''
      } else if (this.CREA < 30) {
        this.CREA1 = this.CREA
        this.CREA2 = ''
        this.CREA3 = ''
      } else {
        this.CREA3 = this.CREA
        this.CREA1 = ''
        this.CREA2 = ''
      }

      if (this.GGT >= 5 && this.GGT <= 54) {
        this.GGT2 = this.GGT
        this.GGT1 = ''
        this.GGT3 = ''
      } else if (this.GGT < 5) {
        this.GGT1 = this.GGT
        this.GGT2 = ''
        this.GGT3 = ''
      } else {
        this.GGT3 = this.GGT
        this.GGT1 = ''
        this.GGT2 = ''
      }

      if (this.PROT >= 0.08 && this.PROT <= 0.43) {
        this.PROT2 = this.PROT
        this.PROT1 = ''
        this.PROT3 = ''
      } else if (this.PROT < 0.08) {
        this.PROT1 = this.PROT
        this.PROT2 = ''
        this.PROT3 = ''
      } else {
        this.PROT3 = this.PROT
        this.PROT1 = ''
        this.PROT2 = ''
      }
    }
  }
}
</script>

<style>
.item {
  position: relative;
  z-index: 999;
}

.index {
  display: flex;
  justify-content: space-around;
  padding-top: 20px;
}

.main {
  /* width: 99.5%; */
  /* height: 25%; */
  text-align: center;
  margin-top: 10px;
}

.el-aside {
  color: #333;
  text-align: center;
  line-height: 50px;
}

.el-main {
  color: #333;
  text-align: left;
  line-height: 40px;
}
</style>
