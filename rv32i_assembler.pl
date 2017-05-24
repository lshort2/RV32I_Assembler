#!/usr/bin/env perl

use strict;
use warnings;
use diagnostics;
use v5.16;
use feature 'say';
use feature 'switch';

my $MAX_LINES = 512;#used to indicate max number of lines for .dat file (dep on instr memory)
###############################################################################
#Instruction Encodings
###############################################################################
my $OP_IMM    = "0010011";
my $BRANCH    = "0000110";
my $ADD       = "0000011";
my $OP_LUI    = "0110111";
my $OP_AUIPC  = "0010111";
my $OP_REG    = "0110011";
my $OP_JAL    = "1101111";
my $OP_JALR   = "1100111";
my $OP_BRANCH = "1100011";
my $OP_LOAD   = "0000011";
my $OP_STORE  = "0100011";
#@@@ check encoding for SUB and SRA






say'Enter name of assembly file';
my $filename_1 = <STDIN>;
chomp($filename_1);#remove newline

my $filename_2 = $filename_1;
$filename_2 =~ s{\.[^.]+$}{}; # removes extension
$filename_2 .= "_m.dat";

#Open assembly file for reading.
open my $fh1, '<', $filename_1 
   or die "Can't open file $_";
#Open .dat file for writing.
open my $fh2, '>', $filename_2 
   or die "Can't open file $_";
say "Reading assembly file: $filename_1";
say " and writing to .dat file: $filename_2";




my $line_count = 0;#used to counter number of lines written

#Set first line of .dat to all zeroes, so circuit can be initialized properly.
print $fh2 "00000000000000000000000000000000\n";
$line_count +=1;

#Lines 2-EOF based on assembly file...
while(my $info = <$fh1>) {
    chomp($info);#remove newline
    if($info ne '') {
        my ($rv_operation, $rv_operands) = split / /, $info;
        say "Operations: $rv_operation";
        say "Operands: $rv_operands";

        given($rv_operation){
            when($_ eq "addi") {
                my ($rd, $rs1, $imm12) = split /,/, $rv_operands;

                my $rd_b = generate_5bit($rd);
                my $rs1_b = generate_5bit($rs1);
                my $imm12_b = generate_imm12($imm12);#subroutine can do conversions, like #4 to 000000000100
                my $funct3 = "000";
                my $opcode = $OP_IMM;

                my $machine_instr = ($imm12_b . $rs1_b . $funct3 . $rd_b . $opcode);
                print $fh2 "$machine_instr\n";
            }
            when($_ eq "slti") {
                my ($rd, $rs1, $imm12) = split /,/, $rv_operands;

                my $rd_b = generate_5bit($rd);
                my $rs1_b = generate_5bit($rs1);
                my $imm12_b = generate_imm12($imm12);
                my $funct3 = "001";
                my $opcode = $OP_IMM;

                my $machine_instr = ($imm12_b . $rs1_b . $funct3 . $rd_b . $opcode);
                print $fh2 "$machine_instr\n";
                #do stuff
                #print "imm12_b=$imm12_b";
                #print "rs1_b=$rs1_b";
                #print "funct3=$funct3";
                #print "rd_b=$rd_b";
                #print "machine_instr=$machine_instr";
            }
            when($_ eq "sltiu") {
                my ($rd, $rs1, $imm12) = split /,/, $rv_operands;

                my $rd_b = generate_5bit($rd);
                my $rs1_b = generate_5bit($rs1);
                my $imm12_b = generate_imm12($imm12);#subroutine can do conversions, like #4 to 000000000100
                my $funct3 = "010";
                my $opcode = $OP_IMM;

                my $machine_instr = ($imm12_b . $rs1_b . $funct3 . $rd_b . $opcode);
                print $fh2 "$machine_instr\n";
            }
            when($_ eq "andi") {
                my ($rd, $rs1, $imm12) = split /,/, $rv_operands;

                my $rd_b = generate_5bit($rd);
                my $rs1_b = generate_5bit($rs1);
                my $imm12_b = generate_imm12($imm12);#subroutine can do conversions, like #4 to 000000000100
                my $funct3 = "011";
                my $opcode = $OP_IMM;

                my $machine_instr = ($imm12_b . $rs1_b . $funct3 . $rd_b . $opcode);
                print $fh2 "$machine_instr\n";
            }
            when($_ eq "ori") {
                my ($rd, $rs1, $imm12) = split /,/, $rv_operands;

                my $rd_b = generate_5bit($rd);
                my $rs1_b = generate_5bit($rs1);
                my $imm12_b = generate_imm12($imm12);#subroutine can do conversions, like #4 to 000000000100
                my $funct3 = "100";
                my $opcode = $OP_IMM;

                my $machine_instr = ($imm12_b . $rs1_b . $funct3 . $rd_b . $opcode);
                print $fh2 "$machine_instr\n";
            }
            when($_ eq "xori") {
                my ($rd, $rs1, $imm12) = split /,/, $rv_operands;

                my $rd_b = generate_5bit($rd);
                my $rs1_b = generate_5bit($rs1);
                my $imm12_b = generate_imm12($imm12);#subroutine can do conversions, like #4 to 000000000100
                my $funct3 = "101";
                my $opcode = $OP_IMM;

                my $machine_instr = ($imm12_b . $rs1_b . $funct3 . $rd_b . $opcode);
                print $fh2 "$machine_instr\n";
            }
            when($_ eq "slli") {
                my ($rd, $rs1, $shamt) = split /,/, $rv_operands;

                my $rd_b    = generate_5bit($rd);
                my $rs1_b   = generate_5bit($rs1);
                my $shamt_b = generate_5bit($shamt);
                my $upper_seven = "0000000";
                my $funct3 = "110";
                my $opcode = $OP_IMM;

                my $machine_instr = ($upper_seven . $shamt_b . $rs1_b . $funct3 . $rd_b . $opcode);
                print $fh2 "$machine_instr\n";
            }
            when($_ eq "srli") {
                my ($rd, $rs1, $shamt) = split /,/, $rv_operands;

                my $rd_b    = generate_5bit($rd);
                my $rs1_b   = generate_5bit($rs1);
                my $shamt_b = generate_5bit($shamt);
                my $upper_seven = "0000000";
                my $funct3 = "111";
                my $opcode = $OP_IMM;

                my $machine_instr = ($upper_seven . $shamt_b . $rs1_b . $funct3 . $rd_b . $opcode);
                print $fh2 "$machine_instr\n";
            }
            when($_ eq "srai") {
                my ($rd, $rs1, $shamt) = split /,/, $rv_operands;

                my $rd_b    = generate_5bit($rd);
                my $rs1_b   = generate_5bit($rs1);
                my $shamt_b = generate_5bit($shamt);
                my $upper_seven = "0100000";
                my $funct3 = "111";
                my $opcode = $OP_IMM;

                my $machine_instr = ($upper_seven . $shamt_b . $rs1_b . $funct3 . $rd_b . $opcode);
                print $fh2 "$machine_instr\n";
            }
            when($_ eq "lui") {
                my ($rd, $imm20) = split /,/, $rv_operands;

                my $rd_b     = generate_5bit($rd);
                my $imm20_b  = generate_imm20($imm20);
                my $opcode = $OP_LUI;

                my $machine_instr = ($imm20_b . $rd_b . $opcode);
                print $fh2 "$machine_instr\n";
            }
            when($_ eq "auipc") {
                my ($rd, $imm20) = split /,/, $rv_operands;

                my $rd_b     = generate_5bit($rd);
                my $imm20_b  = generate_imm20($imm20);
                my $opcode = $OP_AUIPC;

                my $machine_instr = ($imm20_b . $rd_b . $opcode);
                print $fh2 "$machine_instr\n";
            }
            when($_ eq "add") {
                my ($rd, $rs1, $rs2) = split /,/, $rv_operands;

                my $rd_b     = generate_5bit($rd);
                my $rs1_b    = generate_5bit($rs1);
                my $rs2_b    = generate_5bit($rs2);
                my $opcode   = $OP_REG;
                my $funct3   = "000";
                my $funct7   = "0000000";

                my $machine_instr = ($funct7 . $rs2_b . $rs1_b . $funct3 . $rd_b . $opcode);
            }
            when($_ eq "slt") {
                my ($rd, $rs1, $rs2) = split /,/, $rv_operands;

                my $rd_b     = generate_5bit($rd);
                my $rs1_b    = generate_5bit($rs1);
                my $rs2_b    = generate_5bit($rs2);
                my $opcode   = $OP_REG;
                my $funct3   = "001";
                my $funct7   = "0000000";

                my $machine_instr = ($funct7 . $rs2_b . $rs1_b . $funct3 . $rd_b . $opcode);
            }
            when($_ eq "sltu") {
                my ($rd, $rs1, $rs2) = split /,/, $rv_operands;

                my $rd_b     = generate_5bit($rd);
                my $rs1_b    = generate_5bit($rs1);
                my $rs2_b    = generate_5bit($rs2);
                my $opcode   = $OP_REG;
                my $funct3   = "010";
                my $funct7   = "0000000";

                my $machine_instr = ($funct7 . $rs2_b . $rs1_b . $funct3 . $rd_b . $opcode);
            }
            when($_ eq "and") {
                my ($rd, $rs1, $rs2) = split /,/, $rv_operands;

                my $rd_b     = generate_5bit($rd);
                my $rs1_b    = generate_5bit($rs1);
                my $rs2_b    = generate_5bit($rs2);
                my $opcode   = $OP_REG;
                my $funct3   = "011";
                my $funct7   = "0000000";

                my $machine_instr = ($funct7 . $rs2_b . $rs1_b . $funct3 . $rd_b . $opcode);
            }
            when($_ eq "or") {
                my ($rd, $rs1, $rs2) = split /,/, $rv_operands;

                my $rd_b     = generate_5bit($rd);
                my $rs1_b    = generate_5bit($rs1);
                my $rs2_b    = generate_5bit($rs2);
                my $opcode   = $OP_REG;
                my $funct3   = "100";
                my $funct7   = "0000000";

                my $machine_instr = ($funct7 . $rs2_b . $rs1_b . $funct3 . $rd_b . $opcode);
            }
            when($_ eq "xor") {
                my ($rd, $rs1, $rs2) = split /,/, $rv_operands;

                my $rd_b     = generate_5bit($rd);
                my $rs1_b    = generate_5bit($rs1);
                my $rs2_b    = generate_5bit($rs2);
                my $opcode   = $OP_REG;
                my $funct3   = "101";
                my $funct7   = "0000000";

                my $machine_instr = ($funct7 . $rs2_b . $rs1_b . $funct3 . $rd_b . $opcode);
            }
            when($_ eq "sll") {
                my ($rd, $rs1, $rs2) = split /,/, $rv_operands;

                my $rd_b     = generate_5bit($rd);
                my $rs1_b    = generate_5bit($rs1);
                my $rs2_b    = generate_5bit($rs2);
                my $opcode   = $OP_REG;
                my $funct3   = "110";
                my $funct7   = "0000000";

                my $machine_instr = ($funct7 . $rs2_b . $rs1_b . $funct3 . $rd_b . $opcode);
            }
            when($_ eq "srl") {
                my ($rd, $rs1, $rs2) = split /,/, $rv_operands;

                my $rd_b     = generate_5bit($rd);
                my $rs1_b    = generate_5bit($rs1);
                my $rs2_b    = generate_5bit($rs2);
                my $opcode   = $OP_REG;
                my $funct3   = "111";
                my $funct7   = "0000000";

                my $machine_instr = ($funct7 . $rs2_b . $rs1_b . $funct3 . $rd_b . $opcode);
            }
            when($_ eq "sub") {
                my ($rd, $rs1, $rs2) = split /,/, $rv_operands;

                my $rd_b     = generate_5bit($rd);
                my $rs1_b    = generate_5bit($rs1);
                my $rs2_b    = generate_5bit($rs2);
                my $opcode   = $OP_REG;
                my $funct3   = "000";#@@@ ?
                my $funct7   = "0100000";

                my $machine_instr = ($funct7 . $rs2_b . $rs1_b . $funct3 . $rd_b . $opcode);
            }
            when($_ eq "sra") {
                my ($rd, $rs1, $rs2) = split /,/, $rv_operands;

                my $rd_b     = generate_5bit($rd);
                my $rs1_b    = generate_5bit($rs1);
                my $rs2_b    = generate_5bit($rs2);
                my $opcode   = $OP_REG;
                my $funct3   = "101";#@@@ ?
                my $funct7   = "0100000";

                my $machine_instr = ($funct7 . $rs2_b . $rs1_b . $funct3 . $rd_b . $opcode);
            }
            #ADD
            #ADD
            #ADD
            #ADD
            #ADD
            #ADD
            #ADD
            #ADD
            #ADD
            #SRA
            default {  say"nothing";  }
            #default {  die "unrecognized instruction format!!";  }
        }
        $line_count +=1;
    }

    if($line_count >= $MAX_LINES) {
        last;
    }
    print"line_count=$line_count\n";
}
print"line_count=$line_count";
#fill remainder of file w/ 0s
while($line_count < $MAX_LINES) {
    print $fh2 "00000000000000000000000000000000\n";
    $line_count +=1;
}
close $fh1 or die "unable to close $filename_1";
close $fh2 or die "unable to close $filename_2";

#for (my $i=0; $i<$num_instructions; $i++) {
#   given($test_type){
#      when($_ == 0){
#         #Encode reg comp instruction
#      }
#      when($_ == 1){
#         #Encode load/store instruction
#      }
#      when($_ == 2){
#         #Encode reg-reg instruction
#      }
#   }
#
#}
#

sub generate_imm12 {
    my ($conver_me) = @_;
    substr($conver_me, 0, 1, "");#remove first character
    $conver_me ||= 0;#if fxn called w/o parameter, will, provide a zero

    #need to find highest power of 2 this guy is divisble by
    my $highest_power =1;
    my $converted_string ='000000000000';

    for(; 2**$highest_power <= $conver_me; $highest_power++) {
    }
    $highest_power--;

    for(; $highest_power >=0; $highest_power--) {
        if($conver_me >= 2**$highest_power){
            $conver_me -= 2**$highest_power;
            substr($converted_string, (11-$highest_power), 1, '1');
        }
        else{
            substr($converted_string, (11-$highest_power), 1, '0');
        }
    }

    return $converted_string;
}

sub generate_5bit {
    my ($conver_me) = @_;
    substr($conver_me, 0, 1, "");#remove first char
    $conver_me ||= 0;#default to a zero

    #find highest power of 2 this guy is divisble by...
    my $highest_power =1;
    my $converted_string ='00000';

    for(; 2**$highest_power <= $conver_me; $highest_power++) {
    }
    $highest_power--;

    for(; $highest_power >=0; $highest_power--) {
        if($conver_me >= 2**$highest_power){
            $conver_me -= 2**$highest_power;
            substr($converted_string, (4-$highest_power), 1, '1');
        }
        else{
            substr($converted_string, (4-$highest_power), 1, '0');
        }
    }

    return $converted_string;
}

sub generate_imm20 {
    my ($conver_me) = @_;
    substr($conver_me, 0, 1, "");#remove first character
    $conver_me ||= 0;#if fxn called w/o parameter, will, provide a zero

    #need to find highest power of 2 this guy is divisble by
    my $highest_power =1;
    my $converted_string ='00000000000000000000';

    for(; 2**$highest_power <= $conver_me; $highest_power++) {
    }
    $highest_power--;

    for(; $highest_power >=0; $highest_power--) {
        if($conver_me >= 2**$highest_power){
            $conver_me -= 2**$highest_power;
            substr($converted_string, (19-$highest_power), 1, '1');
        }
        else{
            substr($converted_string, (19-$highest_power), 1, '0');
        }
    }

    return $converted_string;
}

