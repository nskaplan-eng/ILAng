; SMT-LIBv2 description generated by Yosys 0.8+598 (git sha1 becd98cc, gcc 7.4.0-1ubuntu1~18.04.1 -fPIC -Os)
; yosys-smt2-stdt
; yosys-smt2-module wrapper
(declare-datatype |wrapper_s| ((|wrapper_mk|
  (|wrapper_is| Bool)
  (|wrapper#0| (_ BitVec 8)) ; \__ILA_I_inst
  (|wrapper#1| (_ BitVec 8)) ; \__ILA_SO_r0
  (|wrapper#2| (_ BitVec 8)) ; \__ILA_SO_r1
  (|wrapper#3| (_ BitVec 8)) ; \__ILA_SO_r2
  (|wrapper#4| (_ BitVec 8)) ; \__ILA_SO_r3
  (|wrapper#5| Bool) ; \__STARTED__
  (|wrapper#6| Bool) ; \__START__
  (|wrapper#7| (_ BitVec 2)) ; \__VLG_I_dummy_read_rf
  (|wrapper#8| (_ BitVec 2)) ; \m1.ex_wb_rd
  (|wrapper#10| (_ BitVec 1)) ; \m1.ex_wb_reg_wen
  (|wrapper#12| (_ BitVec 8)) ; \m1.ex_wb_val
  (|wrapper#15| (_ BitVec 2)) ; \m1.id_ex_op
  (|wrapper#18| (_ BitVec 2)) ; \m1.id_ex_rd
  (|wrapper#21| (_ BitVec 1)) ; \m1.id_ex_reg_wen
  (|wrapper#23| (_ BitVec 8)) ; \m1.id_ex_rs1_val
  (|wrapper#26| (_ BitVec 8)) ; \m1.id_ex_rs2_val
  (|wrapper#29| (_ BitVec 2)) ; \m1.reg_0_w_stage
  (|wrapper#32| (_ BitVec 2)) ; \m1.reg_1_w_stage
  (|wrapper#35| (_ BitVec 2)) ; \m1.reg_2_w_stage
  (|wrapper#38| (_ BitVec 2)) ; \m1.reg_3_w_stage
  (|wrapper#41| (_ BitVec 8)) ; \m1.registers[0]
  (|wrapper#44| (_ BitVec 8)) ; \m1.registers[1]
  (|wrapper#47| (_ BitVec 8)) ; \m1.registers[2]
  (|wrapper#50| (_ BitVec 8)) ; \m1.registers[3]
  (|wrapper#54| Bool) ; \clk
  (|wrapper#61| Bool) ; \rst
)))
; yosys-smt2-input __ILA_I_inst 8
; yosys-smt2-wire __ILA_I_inst 8
(define-fun |wrapper_n __ILA_I_inst| ((state |wrapper_s|)) (_ BitVec 8) (|wrapper#0| state))
; yosys-smt2-output __ILA_SO_r0 8
; yosys-smt2-wire __ILA_SO_r0 8
(define-fun |wrapper_n __ILA_SO_r0| ((state |wrapper_s|)) (_ BitVec 8) (|wrapper#1| state))
; yosys-smt2-output __ILA_SO_r1 8
; yosys-smt2-wire __ILA_SO_r1 8
(define-fun |wrapper_n __ILA_SO_r1| ((state |wrapper_s|)) (_ BitVec 8) (|wrapper#2| state))
; yosys-smt2-output __ILA_SO_r2 8
; yosys-smt2-wire __ILA_SO_r2 8
(define-fun |wrapper_n __ILA_SO_r2| ((state |wrapper_s|)) (_ BitVec 8) (|wrapper#3| state))
; yosys-smt2-output __ILA_SO_r3 8
; yosys-smt2-wire __ILA_SO_r3 8
(define-fun |wrapper_n __ILA_SO_r3| ((state |wrapper_s|)) (_ BitVec 8) (|wrapper#4| state))
; yosys-smt2-input __STARTED__ 1
(define-fun |wrapper_n __STARTED__| ((state |wrapper_s|)) Bool (|wrapper#5| state))
; yosys-smt2-input __START__ 1
(define-fun |wrapper_n __START__| ((state |wrapper_s|)) Bool (|wrapper#6| state))
; yosys-smt2-input __VLG_I_dummy_read_rf 2
; yosys-smt2-wire __VLG_I_dummy_read_rf 2
(define-fun |wrapper_n __VLG_I_dummy_read_rf| ((state |wrapper_s|)) (_ BitVec 2) (|wrapper#7| state))
; yosys-smt2-output __all_assert_wire__ 1
; yosys-smt2-wire __all_assert_wire__ 1
(define-fun |wrapper#9| ((state |wrapper_s|)) Bool (= (|wrapper#8| state) #b11)) ; $eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:96$1_Y
(define-fun |wrapper#11| ((state |wrapper_s|)) Bool (and (or  (|wrapper#9| state) false) (or  (= ((_ extract 0 0) (|wrapper#10| state)) #b1) false))) ; $logic_and$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:98$4_Y
(define-fun |wrapper#13| ((state |wrapper_s|)) Bool (= (|wrapper#12| state) #b11111111)) ; $eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:98$5_Y
(define-fun |wrapper#14| ((state |wrapper_s|)) Bool (and (or  (|wrapper#11| state) false) (or  (|wrapper#13| state) false))) ; $logic_and$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:99$6_Y
(define-fun |wrapper#16| ((state |wrapper_s|)) Bool (= (|wrapper#15| state) #b11)) ; $eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:99$7_Y
(define-fun |wrapper#17| ((state |wrapper_s|)) Bool (and (or  (|wrapper#14| state) false) (or  (|wrapper#16| state) false))) ; $logic_and$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:100$8_Y
(define-fun |wrapper#19| ((state |wrapper_s|)) Bool (= (|wrapper#18| state) #b11)) ; $eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:100$9_Y
(define-fun |wrapper#20| ((state |wrapper_s|)) Bool (and (or  (|wrapper#17| state) false) (or  (|wrapper#19| state) false))) ; $logic_and$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:101$10_Y
(define-fun |wrapper#22| ((state |wrapper_s|)) Bool (and (or  (|wrapper#20| state) false) (or  (= ((_ extract 0 0) (|wrapper#21| state)) #b1) false))) ; $logic_and$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:102$12_Y
(define-fun |wrapper#24| ((state |wrapper_s|)) Bool (= (|wrapper#23| state) #b10011000)) ; $eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:102$13_Y
(define-fun |wrapper#25| ((state |wrapper_s|)) Bool (and (or  (|wrapper#22| state) false) (or  (|wrapper#24| state) false))) ; $logic_and$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:103$14_Y
(define-fun |wrapper#27| ((state |wrapper_s|)) Bool (= (|wrapper#26| state) #b10011000)) ; $eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:103$15_Y
(define-fun |wrapper#28| ((state |wrapper_s|)) Bool (and (or  (|wrapper#25| state) false) (or  (|wrapper#27| state) false))) ; $logic_and$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:104$16_Y
(define-fun |wrapper#30| ((state |wrapper_s|)) Bool (not (or  (= ((_ extract 0 0) (|wrapper#29| state)) #b1) (= ((_ extract 1 1) (|wrapper#29| state)) #b1)))) ; $eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:104$17_Y
(define-fun |wrapper#31| ((state |wrapper_s|)) Bool (and (or  (|wrapper#28| state) false) (or  (|wrapper#30| state) false))) ; $logic_and$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:105$18_Y
(define-fun |wrapper#33| ((state |wrapper_s|)) Bool (= (|wrapper#32| state) #b01)) ; $eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:105$19_Y
(define-fun |wrapper#34| ((state |wrapper_s|)) Bool (and (or  (|wrapper#31| state) false) (or  (|wrapper#33| state) false))) ; $logic_and$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:106$20_Y
(define-fun |wrapper#36| ((state |wrapper_s|)) Bool (not (or  (= ((_ extract 0 0) (|wrapper#35| state)) #b1) (= ((_ extract 1 1) (|wrapper#35| state)) #b1)))) ; $eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:106$21_Y
(define-fun |wrapper#37| ((state |wrapper_s|)) Bool (and (or  (|wrapper#34| state) false) (or  (|wrapper#36| state) false))) ; $logic_and$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:107$22_Y
(define-fun |wrapper#39| ((state |wrapper_s|)) Bool (= (|wrapper#38| state) #b11)) ; $eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:107$23_Y
(define-fun |wrapper#40| ((state |wrapper_s|)) Bool (and (or  (|wrapper#37| state) false) (or  (|wrapper#39| state) false))) ; $logic_and$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:108$24_Y
(define-fun |wrapper#42| ((state |wrapper_s|)) Bool (= (|wrapper#41| state) #b10011000)) ; $eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:108$25_Y
(define-fun |wrapper#43| ((state |wrapper_s|)) Bool (and (or  (|wrapper#40| state) false) (or  (|wrapper#42| state) false))) ; $logic_and$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:109$26_Y
(define-fun |wrapper#45| ((state |wrapper_s|)) Bool (= (|wrapper#44| state) #b11100010)) ; $eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:109$27_Y
(define-fun |wrapper#46| ((state |wrapper_s|)) Bool (and (or  (|wrapper#43| state) false) (or  (|wrapper#45| state) false))) ; $logic_and$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:110$28_Y
(define-fun |wrapper#48| ((state |wrapper_s|)) Bool (= (|wrapper#47| state) #b10001001)) ; $eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:110$29_Y
(define-fun |wrapper#49| ((state |wrapper_s|)) Bool (and (or  (|wrapper#46| state) false) (or  (|wrapper#48| state) false))) ; $logic_and$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:111$30_Y
(define-fun |wrapper#51| ((state |wrapper_s|)) Bool (= (|wrapper#50| state) #b10111000)) ; $eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:111$31_Y
(define-fun |wrapper#52| ((state |wrapper_s|)) Bool (and (or  (|wrapper#49| state) false) (or  (|wrapper#51| state) false))) ; $logic_and$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:111$32_Y
(define-fun |wrapper#53| ((state |wrapper_s|)) (_ BitVec 1) (bvnot (ite (|wrapper#52| state) #b1 #b0))) ; \cex_nonreachable_assert__p0__
(define-fun |wrapper_n __all_assert_wire__| ((state |wrapper_s|)) Bool (= ((_ extract 0 0) (|wrapper#53| state)) #b1))
; yosys-smt2-output cex_nonreachable_assert__p0__ 1
; yosys-smt2-wire cex_nonreachable_assert__p0__ 1
(define-fun |wrapper_n cex_nonreachable_assert__p0__| ((state |wrapper_s|)) Bool (= ((_ extract 0 0) (|wrapper#53| state)) #b1))
; yosys-smt2-input clk 1
; yosys-smt2-clock clk posedge
(define-fun |wrapper_n clk| ((state |wrapper_s|)) Bool (|wrapper#54| state))
; yosys-smt2-output dummy_rf_data 8
; yosys-smt2-wire dummy_rf_data 8
(define-fun |wrapper#55| ((state |wrapper_s|)) Bool (= (|wrapper#7| state) #b10)) ; $techmap\m1.$eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:219$42_Y
(define-fun |wrapper#56| ((state |wrapper_s|)) (_ BitVec 8) (ite (|wrapper#55| state) (|wrapper#47| state) (|wrapper#50| state))) ; $techmap\m1.$ternary$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:220$43_Y
(define-fun |wrapper#57| ((state |wrapper_s|)) Bool (= (|wrapper#7| state) #b01)) ; $techmap\m1.$eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:218$41_Y
(define-fun |wrapper#58| ((state |wrapper_s|)) (_ BitVec 8) (ite (|wrapper#57| state) (|wrapper#44| state) (|wrapper#56| state))) ; $techmap\m1.$ternary$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:220$44_Y
(define-fun |wrapper#59| ((state |wrapper_s|)) Bool (not (or  (= ((_ extract 0 0) (|wrapper#7| state)) #b1) (= ((_ extract 1 1) (|wrapper#7| state)) #b1)))) ; $techmap\m1.$eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:217$40_Y
(define-fun |wrapper#60| ((state |wrapper_s|)) (_ BitVec 8) (ite (|wrapper#59| state) (|wrapper#41| state) (|wrapper#58| state))) ; \m1.dummy_rf_data
(define-fun |wrapper_n dummy_rf_data| ((state |wrapper_s|)) (_ BitVec 8) (|wrapper#60| state))
; yosys-smt2-register m1.ex_wb_rd 2
(define-fun |wrapper_n m1.ex_wb_rd| ((state |wrapper_s|)) (_ BitVec 2) (|wrapper#8| state))
; yosys-smt2-register m1.ex_wb_reg_wen 1
(define-fun |wrapper_n m1.ex_wb_reg_wen| ((state |wrapper_s|)) Bool (= ((_ extract 0 0) (|wrapper#10| state)) #b1))
; yosys-smt2-register m1.ex_wb_val 8
(define-fun |wrapper_n m1.ex_wb_val| ((state |wrapper_s|)) (_ BitVec 8) (|wrapper#12| state))
; yosys-smt2-register m1.id_ex_op 2
(define-fun |wrapper_n m1.id_ex_op| ((state |wrapper_s|)) (_ BitVec 2) (|wrapper#15| state))
; yosys-smt2-register m1.id_ex_rd 2
(define-fun |wrapper_n m1.id_ex_rd| ((state |wrapper_s|)) (_ BitVec 2) (|wrapper#18| state))
; yosys-smt2-register m1.id_ex_reg_wen 1
(define-fun |wrapper_n m1.id_ex_reg_wen| ((state |wrapper_s|)) Bool (= ((_ extract 0 0) (|wrapper#21| state)) #b1))
; yosys-smt2-register m1.id_ex_rs1_val 8
(define-fun |wrapper_n m1.id_ex_rs1_val| ((state |wrapper_s|)) (_ BitVec 8) (|wrapper#23| state))
; yosys-smt2-register m1.id_ex_rs2_val 8
(define-fun |wrapper_n m1.id_ex_rs2_val| ((state |wrapper_s|)) (_ BitVec 8) (|wrapper#26| state))
; yosys-smt2-register m1.reg_0_w_stage 2
(define-fun |wrapper_n m1.reg_0_w_stage| ((state |wrapper_s|)) (_ BitVec 2) (|wrapper#29| state))
; yosys-smt2-register m1.reg_1_w_stage 2
(define-fun |wrapper_n m1.reg_1_w_stage| ((state |wrapper_s|)) (_ BitVec 2) (|wrapper#32| state))
; yosys-smt2-register m1.reg_2_w_stage 2
(define-fun |wrapper_n m1.reg_2_w_stage| ((state |wrapper_s|)) (_ BitVec 2) (|wrapper#35| state))
; yosys-smt2-register m1.reg_3_w_stage 2
(define-fun |wrapper_n m1.reg_3_w_stage| ((state |wrapper_s|)) (_ BitVec 2) (|wrapper#38| state))
; yosys-smt2-register m1.registers[0] 8
(define-fun |wrapper_n m1.registers[0]| ((state |wrapper_s|)) (_ BitVec 8) (|wrapper#41| state))
; yosys-smt2-register m1.registers[1] 8
(define-fun |wrapper_n m1.registers[1]| ((state |wrapper_s|)) (_ BitVec 8) (|wrapper#44| state))
; yosys-smt2-register m1.registers[2] 8
(define-fun |wrapper_n m1.registers[2]| ((state |wrapper_s|)) (_ BitVec 8) (|wrapper#47| state))
; yosys-smt2-register m1.registers[3] 8
(define-fun |wrapper_n m1.registers[3]| ((state |wrapper_s|)) (_ BitVec 8) (|wrapper#50| state))
; yosys-smt2-output m1__DOT__ex_wb_rd 2
; yosys-smt2-wire m1__DOT__ex_wb_rd 2
(define-fun |wrapper_n m1__DOT__ex_wb_rd| ((state |wrapper_s|)) (_ BitVec 2) (|wrapper#8| state))
; yosys-smt2-output m1__DOT__ex_wb_reg_wen 1
; yosys-smt2-wire m1__DOT__ex_wb_reg_wen 1
(define-fun |wrapper_n m1__DOT__ex_wb_reg_wen| ((state |wrapper_s|)) Bool (= ((_ extract 0 0) (|wrapper#10| state)) #b1))
; yosys-smt2-output m1__DOT__ex_wb_val 8
; yosys-smt2-wire m1__DOT__ex_wb_val 8
(define-fun |wrapper_n m1__DOT__ex_wb_val| ((state |wrapper_s|)) (_ BitVec 8) (|wrapper#12| state))
; yosys-smt2-output m1__DOT__id_ex_op 2
; yosys-smt2-wire m1__DOT__id_ex_op 2
(define-fun |wrapper_n m1__DOT__id_ex_op| ((state |wrapper_s|)) (_ BitVec 2) (|wrapper#15| state))
; yosys-smt2-output m1__DOT__id_ex_rd 2
; yosys-smt2-wire m1__DOT__id_ex_rd 2
(define-fun |wrapper_n m1__DOT__id_ex_rd| ((state |wrapper_s|)) (_ BitVec 2) (|wrapper#18| state))
; yosys-smt2-output m1__DOT__id_ex_reg_wen 1
; yosys-smt2-wire m1__DOT__id_ex_reg_wen 1
(define-fun |wrapper_n m1__DOT__id_ex_reg_wen| ((state |wrapper_s|)) Bool (= ((_ extract 0 0) (|wrapper#21| state)) #b1))
; yosys-smt2-output m1__DOT__id_ex_rs1_val 8
; yosys-smt2-wire m1__DOT__id_ex_rs1_val 8
(define-fun |wrapper_n m1__DOT__id_ex_rs1_val| ((state |wrapper_s|)) (_ BitVec 8) (|wrapper#23| state))
; yosys-smt2-output m1__DOT__id_ex_rs2_val 8
; yosys-smt2-wire m1__DOT__id_ex_rs2_val 8
(define-fun |wrapper_n m1__DOT__id_ex_rs2_val| ((state |wrapper_s|)) (_ BitVec 8) (|wrapper#26| state))
; yosys-smt2-output m1__DOT__reg_0_w_stage 2
; yosys-smt2-wire m1__DOT__reg_0_w_stage 2
(define-fun |wrapper_n m1__DOT__reg_0_w_stage| ((state |wrapper_s|)) (_ BitVec 2) (|wrapper#29| state))
; yosys-smt2-output m1__DOT__reg_1_w_stage 2
; yosys-smt2-wire m1__DOT__reg_1_w_stage 2
(define-fun |wrapper_n m1__DOT__reg_1_w_stage| ((state |wrapper_s|)) (_ BitVec 2) (|wrapper#32| state))
; yosys-smt2-output m1__DOT__reg_2_w_stage 2
; yosys-smt2-wire m1__DOT__reg_2_w_stage 2
(define-fun |wrapper_n m1__DOT__reg_2_w_stage| ((state |wrapper_s|)) (_ BitVec 2) (|wrapper#35| state))
; yosys-smt2-output m1__DOT__reg_3_w_stage 2
; yosys-smt2-wire m1__DOT__reg_3_w_stage 2
(define-fun |wrapper_n m1__DOT__reg_3_w_stage| ((state |wrapper_s|)) (_ BitVec 2) (|wrapper#38| state))
; yosys-smt2-output m1__DOT__registers_0_ 8
; yosys-smt2-wire m1__DOT__registers_0_ 8
(define-fun |wrapper_n m1__DOT__registers_0_| ((state |wrapper_s|)) (_ BitVec 8) (|wrapper#41| state))
; yosys-smt2-output m1__DOT__registers_1_ 8
; yosys-smt2-wire m1__DOT__registers_1_ 8
(define-fun |wrapper_n m1__DOT__registers_1_| ((state |wrapper_s|)) (_ BitVec 8) (|wrapper#44| state))
; yosys-smt2-output m1__DOT__registers_2_ 8
; yosys-smt2-wire m1__DOT__registers_2_ 8
(define-fun |wrapper_n m1__DOT__registers_2_| ((state |wrapper_s|)) (_ BitVec 8) (|wrapper#47| state))
; yosys-smt2-output m1__DOT__registers_3_ 8
; yosys-smt2-wire m1__DOT__registers_3_ 8
(define-fun |wrapper_n m1__DOT__registers_3_| ((state |wrapper_s|)) (_ BitVec 8) (|wrapper#50| state))
; yosys-smt2-input rst 1
(define-fun |wrapper_n rst| ((state |wrapper_s|)) Bool (|wrapper#61| state))
; yosys-smt2-assert 0 /home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:136
(define-fun |wrapper_a 0| ((state |wrapper_s|)) Bool (or (= ((_ extract 0 0) (|wrapper#53| state)) #b1) (not true))) ; $assert$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:136$34
(define-fun |wrapper#62| ((state |wrapper_s|)) (_ BitVec 8) (ite (|wrapper#9| state) (|wrapper#12| state) (|wrapper#50| state))) ; $techmap\m1.$procmux$110_Y
(define-fun |wrapper#63| ((state |wrapper_s|)) (_ BitVec 8) (ite (= ((_ extract 0 0) (|wrapper#10| state)) #b1) (|wrapper#62| state) (|wrapper#50| state))) ; $techmap\m1.$procmux$112_Y
(define-fun |wrapper#64| ((state |wrapper_s|)) (_ BitVec 8) (ite (|wrapper#61| state) #b00000000 (|wrapper#63| state))) ; $techmap\m1.$0\registers[3][7:0]
(define-fun |wrapper#65| ((state |wrapper_s|)) Bool (= (|wrapper#8| state) #b10)) ; $techmap\m1.$procmux$119_CMP
(define-fun |wrapper#66| ((state |wrapper_s|)) (_ BitVec 8) (ite (|wrapper#65| state) (|wrapper#12| state) (|wrapper#47| state))) ; $techmap\m1.$procmux$118_Y
(define-fun |wrapper#67| ((state |wrapper_s|)) (_ BitVec 8) (ite (= ((_ extract 0 0) (|wrapper#10| state)) #b1) (|wrapper#66| state) (|wrapper#47| state))) ; $techmap\m1.$procmux$120_Y
(define-fun |wrapper#68| ((state |wrapper_s|)) (_ BitVec 8) (ite (|wrapper#61| state) #b00000000 (|wrapper#67| state))) ; $techmap\m1.$0\registers[2][7:0]
(define-fun |wrapper#69| ((state |wrapper_s|)) Bool (= (|wrapper#8| state) #b01)) ; $techmap\m1.$procmux$128_CMP
(define-fun |wrapper#70| ((state |wrapper_s|)) (_ BitVec 8) (ite (|wrapper#69| state) (|wrapper#12| state) (|wrapper#44| state))) ; $techmap\m1.$procmux$127_Y
(define-fun |wrapper#71| ((state |wrapper_s|)) (_ BitVec 8) (ite (= ((_ extract 0 0) (|wrapper#10| state)) #b1) (|wrapper#70| state) (|wrapper#44| state))) ; $techmap\m1.$procmux$129_Y
(define-fun |wrapper#72| ((state |wrapper_s|)) (_ BitVec 8) (ite (|wrapper#61| state) #b00000000 (|wrapper#71| state))) ; $techmap\m1.$0\registers[1][7:0]
(define-fun |wrapper#73| ((state |wrapper_s|)) Bool (not (or  (= ((_ extract 0 0) (|wrapper#8| state)) #b1) (= ((_ extract 1 1) (|wrapper#8| state)) #b1)))) ; $techmap\m1.$procmux$138_CMP
(define-fun |wrapper#74| ((state |wrapper_s|)) (_ BitVec 8) (ite (|wrapper#73| state) (|wrapper#12| state) (|wrapper#41| state))) ; $techmap\m1.$procmux$137_Y
(define-fun |wrapper#75| ((state |wrapper_s|)) (_ BitVec 8) (ite (= ((_ extract 0 0) (|wrapper#10| state)) #b1) (|wrapper#74| state) (|wrapper#41| state))) ; $techmap\m1.$procmux$139_Y
(define-fun |wrapper#76| ((state |wrapper_s|)) (_ BitVec 8) (ite (|wrapper#61| state) #b00000000 (|wrapper#75| state))) ; $techmap\m1.$0\registers[0][7:0]
(define-fun |wrapper#77| ((state |wrapper_s|)) (_ BitVec 2) (bvor (concat #b0 ((_ extract 1 1) (|wrapper#38| state))) #b10)) ; $techmap\m1.$or$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:268$61_Y
(define-fun |wrapper#78| ((state |wrapper_s|)) Bool (= ((_ extract 7 6) (|wrapper#0| state)) #b01)) ; $techmap\m1.$eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:215$35_Y
(define-fun |wrapper#79| ((state |wrapper_s|)) Bool (= ((_ extract 7 6) (|wrapper#0| state)) #b10)) ; $techmap\m1.$eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:215$36_Y
(define-fun |wrapper#80| ((state |wrapper_s|)) Bool (or  (|wrapper#78| state) false  (|wrapper#79| state) false)) ; $techmap\m1.$logic_or$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:215$37_Y
(define-fun |wrapper#81| ((state |wrapper_s|)) Bool (= ((_ extract 7 6) (|wrapper#0| state)) #b11)) ; $techmap\m1.$eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:215$38_Y
(define-fun |wrapper#82| ((state |wrapper_s|)) Bool (or  (|wrapper#80| state) false  (|wrapper#81| state) false)) ; \m1.id_wen
(define-fun |wrapper#83| ((state |wrapper_s|)) Bool (= ((_ extract 1 0) (|wrapper#0| state)) #b11)) ; $techmap\m1.$eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:267$59_Y
(define-fun |wrapper#84| ((state |wrapper_s|)) Bool (and (or  (|wrapper#82| state) false) (or  (|wrapper#83| state) false))) ; $techmap\m1.$logic_and$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:267$60_Y
(define-fun |wrapper#85| ((state |wrapper_s|)) (_ BitVec 2) (ite (|wrapper#84| state) (|wrapper#77| state) (concat #b0 ((_ extract 1 1) (|wrapper#38| state))))) ; $techmap\m1.$procmux$169_Y
(define-fun |wrapper#86| ((state |wrapper_s|)) (_ BitVec 2) (ite (|wrapper#61| state) #b00 (|wrapper#85| state))) ; $techmap\m1.$0\reg_3_w_stage[1:0]
(define-fun |wrapper#87| ((state |wrapper_s|)) (_ BitVec 2) (bvor (concat #b0 ((_ extract 1 1) (|wrapper#35| state))) #b10)) ; $techmap\m1.$or$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:256$57_Y
(define-fun |wrapper#88| ((state |wrapper_s|)) Bool (= ((_ extract 1 0) (|wrapper#0| state)) #b10)) ; $techmap\m1.$eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:255$55_Y
(define-fun |wrapper#89| ((state |wrapper_s|)) Bool (and (or  (|wrapper#82| state) false) (or  (|wrapper#88| state) false))) ; $techmap\m1.$logic_and$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:255$56_Y
(define-fun |wrapper#90| ((state |wrapper_s|)) (_ BitVec 2) (ite (|wrapper#89| state) (|wrapper#87| state) (concat #b0 ((_ extract 1 1) (|wrapper#35| state))))) ; $techmap\m1.$procmux$175_Y
(define-fun |wrapper#91| ((state |wrapper_s|)) (_ BitVec 2) (ite (|wrapper#61| state) #b00 (|wrapper#90| state))) ; $techmap\m1.$0\reg_2_w_stage[1:0]
(define-fun |wrapper#92| ((state |wrapper_s|)) (_ BitVec 2) (bvor (concat #b0 ((_ extract 1 1) (|wrapper#32| state))) #b10)) ; $techmap\m1.$or$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:244$53_Y
(define-fun |wrapper#93| ((state |wrapper_s|)) Bool (= ((_ extract 1 0) (|wrapper#0| state)) #b01)) ; $techmap\m1.$eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:243$51_Y
(define-fun |wrapper#94| ((state |wrapper_s|)) Bool (and (or  (|wrapper#82| state) false) (or  (|wrapper#93| state) false))) ; $techmap\m1.$logic_and$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:243$52_Y
(define-fun |wrapper#95| ((state |wrapper_s|)) (_ BitVec 2) (ite (|wrapper#94| state) (|wrapper#92| state) (concat #b0 ((_ extract 1 1) (|wrapper#32| state))))) ; $techmap\m1.$procmux$181_Y
(define-fun |wrapper#96| ((state |wrapper_s|)) (_ BitVec 2) (ite (|wrapper#61| state) #b00 (|wrapper#95| state))) ; $techmap\m1.$0\reg_1_w_stage[1:0]
(define-fun |wrapper#97| ((state |wrapper_s|)) (_ BitVec 2) (bvor (concat #b0 ((_ extract 1 1) (|wrapper#29| state))) #b10)) ; $techmap\m1.$or$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:232$49_Y
(define-fun |wrapper#98| ((state |wrapper_s|)) Bool (not (or  (= ((_ extract 0 0) (|wrapper#0| state)) #b1) (= ((_ extract 1 1) (|wrapper#0| state)) #b1)))) ; $techmap\m1.$eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:231$47_Y
(define-fun |wrapper#99| ((state |wrapper_s|)) Bool (and (or  (|wrapper#82| state) false) (or  (|wrapper#98| state) false))) ; $techmap\m1.$logic_and$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:231$48_Y
(define-fun |wrapper#100| ((state |wrapper_s|)) (_ BitVec 2) (ite (|wrapper#99| state) (|wrapper#97| state) (concat #b0 ((_ extract 1 1) (|wrapper#29| state))))) ; $techmap\m1.$procmux$187_Y
(define-fun |wrapper#101| ((state |wrapper_s|)) (_ BitVec 2) (ite (|wrapper#61| state) #b00 (|wrapper#100| state))) ; $techmap\m1.$0\reg_0_w_stage[1:0]
(define-fun |wrapper#102| ((state |wrapper_s|)) (_ BitVec 8) (bvand (|wrapper#23| state) (|wrapper#26| state))) ; $techmap\m1.$and$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:322$104_Y
(define-fun |wrapper#103| ((state |wrapper_s|)) (_ BitVec 8) (bvsub (|wrapper#23| state) (|wrapper#26| state))) ; $techmap\m1.$sub$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:321$102_Y
(define-fun |wrapper#104| ((state |wrapper_s|)) Bool (= (|wrapper#15| state) #b10)) ; $techmap\m1.$eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:321$101_Y
(define-fun |wrapper#105| ((state |wrapper_s|)) (_ BitVec 8) (ite (|wrapper#104| state) (|wrapper#103| state) (|wrapper#102| state))) ; $techmap\m1.$ternary$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:323$106_Y
(define-fun |wrapper#106| ((state |wrapper_s|)) (_ BitVec 8) (bvadd (|wrapper#23| state) (|wrapper#26| state))) ; $techmap\m1.$add$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:320$100_Y
(define-fun |wrapper#107| ((state |wrapper_s|)) Bool (= (|wrapper#15| state) #b01)) ; $techmap\m1.$eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:320$99_Y
(define-fun |wrapper#108| ((state |wrapper_s|)) (_ BitVec 8) (ite (|wrapper#107| state) (|wrapper#106| state) (|wrapper#105| state))) ; \m1.ex_alu_result
(define-fun |wrapper#109| ((state |wrapper_s|)) Bool (= ((_ extract 3 2) (|wrapper#0| state)) #b10)) ; $techmap\m1.$eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:285$72_Y
(define-fun |wrapper#110| ((state |wrapper_s|)) (_ BitVec 2) (ite (|wrapper#109| state) (|wrapper#35| state) (|wrapper#38| state))) ; $techmap\m1.$ternary$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:286$73_Y
(define-fun |wrapper#111| ((state |wrapper_s|)) Bool (= ((_ extract 3 2) (|wrapper#0| state)) #b01)) ; $techmap\m1.$eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:284$71_Y
(define-fun |wrapper#112| ((state |wrapper_s|)) (_ BitVec 2) (ite (|wrapper#111| state) (|wrapper#32| state) (|wrapper#110| state))) ; $techmap\m1.$auto$wreduce.cc:455:run$209 [1:0]
(define-fun |wrapper#113| ((state |wrapper_s|)) Bool (not (or  (= ((_ extract 2 2) (|wrapper#0| state)) #b1) (= ((_ extract 3 3) (|wrapper#0| state)) #b1)))) ; $techmap\m1.$eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:283$70_Y
(define-fun |wrapper#114| ((state |wrapper_s|)) (_ BitVec 2) (ite (|wrapper#113| state) (|wrapper#29| state) (|wrapper#112| state))) ; \m1.rs2_stage_info
(define-fun |wrapper#115| ((state |wrapper_s|)) Bool (= (|wrapper#114| state) #b01)) ; $techmap\m1.$eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:303$95_Y
(define-fun |wrapper#116| ((state |wrapper_s|)) (_ BitVec 8) (ite (|wrapper#115| state) (|wrapper#12| state) (|wrapper#108| state))) ; $techmap\m1.$ternary$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:304$96_Y
(define-fun |wrapper#117| ((state |wrapper_s|)) (_ BitVec 8) (ite (|wrapper#109| state) (|wrapper#47| state) (|wrapper#50| state))) ; $techmap\m1.$ternary$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:296$87_Y
(define-fun |wrapper#118| ((state |wrapper_s|)) (_ BitVec 8) (ite (|wrapper#111| state) (|wrapper#44| state) (|wrapper#117| state))) ; $techmap\m1.$ternary$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:296$88_Y
(define-fun |wrapper#119| ((state |wrapper_s|)) (_ BitVec 8) (ite (|wrapper#113| state) (|wrapper#41| state) (|wrapper#118| state))) ; \m1.rs2_val
(define-fun |wrapper#120| ((state |wrapper_s|)) Bool (not (or  (= ((_ extract 0 0) (|wrapper#114| state)) #b1) (= ((_ extract 1 1) (|wrapper#114| state)) #b1) false))) ; $techmap\m1.$eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:302$94_Y
(define-fun |wrapper#121| ((state |wrapper_s|)) (_ BitVec 8) (ite (|wrapper#120| state) (|wrapper#119| state) (|wrapper#116| state))) ; \m1.id_rs2_val
(define-fun |wrapper#122| ((state |wrapper_s|)) (_ BitVec 8) (ite (|wrapper#61| state) (|wrapper#26| state) (|wrapper#121| state))) ; $techmap\m1.$0\id_ex_rs2_val[7:0]
(define-fun |wrapper#123| ((state |wrapper_s|)) Bool (= ((_ extract 5 4) (|wrapper#0| state)) #b10)) ; $techmap\m1.$eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:280$64_Y
(define-fun |wrapper#124| ((state |wrapper_s|)) (_ BitVec 2) (ite (|wrapper#123| state) (|wrapper#35| state) (|wrapper#38| state))) ; $techmap\m1.$ternary$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:281$65_Y
(define-fun |wrapper#125| ((state |wrapper_s|)) Bool (= ((_ extract 5 4) (|wrapper#0| state)) #b01)) ; $techmap\m1.$eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:279$63_Y
(define-fun |wrapper#126| ((state |wrapper_s|)) (_ BitVec 2) (ite (|wrapper#125| state) (|wrapper#32| state) (|wrapper#124| state))) ; $techmap\m1.$auto$wreduce.cc:455:run$208 [1:0]
(define-fun |wrapper#127| ((state |wrapper_s|)) Bool (not (or  (= ((_ extract 4 4) (|wrapper#0| state)) #b1) (= ((_ extract 5 5) (|wrapper#0| state)) #b1)))) ; $techmap\m1.$eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:278$62_Y
(define-fun |wrapper#128| ((state |wrapper_s|)) (_ BitVec 2) (ite (|wrapper#127| state) (|wrapper#29| state) (|wrapper#126| state))) ; \m1.rs1_stage_info
(define-fun |wrapper#129| ((state |wrapper_s|)) Bool (= (|wrapper#128| state) #b01)) ; $techmap\m1.$eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:299$91_Y
(define-fun |wrapper#130| ((state |wrapper_s|)) (_ BitVec 8) (ite (|wrapper#129| state) (|wrapper#12| state) (|wrapper#108| state))) ; $techmap\m1.$ternary$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:300$92_Y
(define-fun |wrapper#131| ((state |wrapper_s|)) (_ BitVec 8) (ite (|wrapper#123| state) (|wrapper#47| state) (|wrapper#50| state))) ; $techmap\m1.$ternary$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:292$81_Y
(define-fun |wrapper#132| ((state |wrapper_s|)) (_ BitVec 8) (ite (|wrapper#125| state) (|wrapper#44| state) (|wrapper#131| state))) ; $techmap\m1.$ternary$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:292$82_Y
(define-fun |wrapper#133| ((state |wrapper_s|)) (_ BitVec 8) (ite (|wrapper#127| state) (|wrapper#41| state) (|wrapper#132| state))) ; \m1.rs1_val
(define-fun |wrapper#134| ((state |wrapper_s|)) Bool (not (or  (= ((_ extract 0 0) (|wrapper#128| state)) #b1) (= ((_ extract 1 1) (|wrapper#128| state)) #b1) false))) ; $techmap\m1.$eq$/home/hongce/ila/ila-stable/test/unit-data/inv_syn/vpipe-out-abc-aig-enhance/inv-enhance/wrapper.v:298$90_Y
(define-fun |wrapper#135| ((state |wrapper_s|)) (_ BitVec 8) (ite (|wrapper#134| state) (|wrapper#133| state) (|wrapper#130| state))) ; \m1.id_rs1_val
(define-fun |wrapper#136| ((state |wrapper_s|)) (_ BitVec 8) (ite (|wrapper#61| state) (|wrapper#23| state) (|wrapper#135| state))) ; $techmap\m1.$0\id_ex_rs1_val[7:0]
(define-fun |wrapper#137| ((state |wrapper_s|)) (_ BitVec 1) (ite (|wrapper#61| state) #b0 (ite (|wrapper#82| state) #b1 #b0))) ; $techmap\m1.$0\id_ex_reg_wen[0:0]
(define-fun |wrapper#138| ((state |wrapper_s|)) (_ BitVec 2) (ite (|wrapper#61| state) (|wrapper#18| state) ((_ extract 1 0) (|wrapper#0| state)))) ; $techmap\m1.$0\id_ex_rd[1:0]
(define-fun |wrapper#139| ((state |wrapper_s|)) (_ BitVec 2) (ite (|wrapper#61| state) (|wrapper#15| state) ((_ extract 7 6) (|wrapper#0| state)))) ; $techmap\m1.$0\id_ex_op[1:0]
(define-fun |wrapper#140| ((state |wrapper_s|)) (_ BitVec 8) (ite (|wrapper#61| state) (|wrapper#12| state) (|wrapper#108| state))) ; $techmap\m1.$0\ex_wb_val[7:0]
(define-fun |wrapper#141| ((state |wrapper_s|)) (_ BitVec 1) (ite (|wrapper#61| state) #b0 (|wrapper#21| state))) ; $techmap\m1.$0\ex_wb_reg_wen[0:0]
(define-fun |wrapper#142| ((state |wrapper_s|)) (_ BitVec 2) (ite (|wrapper#61| state) (|wrapper#8| state) (|wrapper#18| state))) ; $techmap\m1.$0\ex_wb_rd[1:0]
(define-fun |wrapper_a| ((state |wrapper_s|)) Bool 
  (|wrapper_a 0| state)
)
(define-fun |wrapper_u| ((state |wrapper_s|)) Bool true)
(define-fun |wrapper_i| ((state |wrapper_s|)) Bool (and
  (= (= ((_ extract 0 0) (|wrapper#10| state)) #b1) false) ; m1.ex_wb_reg_wen
  (= (= ((_ extract 0 0) (|wrapper#21| state)) #b1) false) ; m1.id_ex_reg_wen
  (= (|wrapper#29| state) #b00) ; m1.reg_0_w_stage
  (= (|wrapper#32| state) #b00) ; m1.reg_1_w_stage
  (= (|wrapper#35| state) #b00) ; m1.reg_2_w_stage
  (= (|wrapper#38| state) #b00) ; m1.reg_3_w_stage
  (= (|wrapper#41| state) #b00000000) ; m1.registers[0]
  (= (|wrapper#44| state) #b00000000) ; m1.registers[1]
  (= (|wrapper#47| state) #b00000000) ; m1.registers[2]
  (= (|wrapper#50| state) #b00000000) ; m1.registers[3]
))
(define-fun |wrapper_h| ((state |wrapper_s|)) Bool true)
(define-fun |wrapper_t| ((state |wrapper_s|) (next_state |wrapper_s|)) Bool (and
  (= (|wrapper#64| state) (|wrapper#50| next_state)) ; $techmap/m1.$procdff$195 \m1.registers[3]
  (= (|wrapper#68| state) (|wrapper#47| next_state)) ; $techmap/m1.$procdff$194 \m1.registers[2]
  (= (|wrapper#72| state) (|wrapper#44| next_state)) ; $techmap/m1.$procdff$193 \m1.registers[1]
  (= (|wrapper#76| state) (|wrapper#41| next_state)) ; $techmap/m1.$procdff$192 \m1.registers[0]
  (= (|wrapper#86| state) (|wrapper#38| next_state)) ; $techmap/m1.$procdff$204 \m1.reg_3_w_stage
  (= (|wrapper#91| state) (|wrapper#35| next_state)) ; $techmap/m1.$procdff$205 \m1.reg_2_w_stage
  (= (|wrapper#96| state) (|wrapper#32| next_state)) ; $techmap/m1.$procdff$206 \m1.reg_1_w_stage
  (= (|wrapper#101| state) (|wrapper#29| next_state)) ; $techmap/m1.$procdff$207 \m1.reg_0_w_stage
  (= (|wrapper#122| state) (|wrapper#26| next_state)) ; $techmap/m1.$procdff$201 \m1.id_ex_rs2_val
  (= (|wrapper#136| state) (|wrapper#23| next_state)) ; $techmap/m1.$procdff$200 \m1.id_ex_rs1_val
  (= (|wrapper#137| state) (|wrapper#21| next_state)) ; $techmap/m1.$procdff$203 \m1.id_ex_reg_wen
  (= (|wrapper#138| state) (|wrapper#18| next_state)) ; $techmap/m1.$procdff$199 \m1.id_ex_rd
  (= (|wrapper#139| state) (|wrapper#15| next_state)) ; $techmap/m1.$procdff$202 \m1.id_ex_op
  (= (|wrapper#140| state) (|wrapper#12| next_state)) ; $techmap/m1.$procdff$196 \m1.ex_wb_val
  (= (|wrapper#141| state) (|wrapper#10| next_state)) ; $techmap/m1.$procdff$198 \m1.ex_wb_reg_wen
  (= (|wrapper#142| state) (|wrapper#8| next_state)) ; $techmap/m1.$procdff$197 \m1.ex_wb_rd
)) ; end of module wrapper
; yosys-smt2-topmod wrapper
; end of yosys output
