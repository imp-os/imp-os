<?php

/**
 * Copyright 2019 AbbeyCatUK
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// convert a given byte value (representing 8 white/black pixels for a row of an ASCII character)
// and transform it into 4 x 64-bit words that will allow AArch64 to "blit" this on-screen

echo "uintptr_t fontdata_64bit[] __attribute__((aligned(16))) = \n";
echo "{\n";

for ( $i = 0x00; $i <= 0xff; $i++ ) {
    
    // 1 bit (1 pixel) = a single 32-bit word (0xRRGGBBAA)
    // an entire row of ASCII pixels will require 4 x 64-bit words
    echo "\t/* 0x" . str_pad( dechex( $i ), 2, "0", STR_PAD_LEFT ) . " */ ";

    for ( $bit = 7; $bit >= 0; $bit -= 2 ) {
        $word  = ( $i & ( 1 << ($bit-1) ) ) ? "ffffffff" : "00000000";
        $word .= ( $i & ( 1 << ($bit-0) ) ) ? "ffffffff" : "00000000";
        echo "0x{$word},";
    }
    echo "\n";
    
}

echo "};\n";
