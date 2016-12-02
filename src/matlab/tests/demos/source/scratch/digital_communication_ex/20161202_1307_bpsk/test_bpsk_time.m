%  ch_bs_geneation = 'round_rand';
ch_bs_geneation = 'randi';

%  ch_bit_repl = 'use_reshape';
ch_bit_repl = 'use_compact_method';

ch_inputs = 2;

switch ch_inputs
    case 1
        no_bits = 8; % number of bits in the sequence
        T = 1; % Bit duration
        no_periods_per_bit = 4;
        no_samples_per_period = 101;
        
    case 2
        no_bits = 5; % number of bits in the sequence
        T = 2.5; % Bit duration
        no_periods_per_bit = 3;
        no_samples_per_period = 21;
end


switch lower( 'round_rand' )
    case 'round_rand'
        bit_stream = round( rand( 1 , no_bits ) );
    case 'randi'
        bit_stream = randi( 2 , 1 , no_bits ) - 1;
end

bit_stream_converted = 2 * bit_stream - 1;
fc = no_periods_per_bit / T; % Carrier frequency
t = linspace( 0 , T * no_bits , 1 + no_bits * no_periods_per_bit * no_samples_per_period );
t = t(1:end-1);

no_samples_per_bit = no_samples_per_period * no_periods_per_bit;
bit_stream_rep           = repmat ( bit_stream'           , 1 , no_samples_per_bit );
bit_stream_converted_rep = repmat ( bit_stream_converted' , 1 , no_samples_per_bit );

switch lower( ch_bit_repl )
    case 'use_reshape'
        bit_stream_rep           = ...
            reshape( bit_stream_rep'           , 1 , no_samples_per_bit * no_bits );
        bit_stream_converted_rep = ...
            reshape( bit_stream_converted_rep' , 1 , no_samples_per_bit * no_bits );
    case 'use_compact_method'
        bit_stream_rep = bit_stream_rep' ; 
        bit_stream_rep = bit_stream_rep(:)';
        bit_stream_converted_rep = bit_stream_converted_rep';
        bit_stream_converted_rep = bit_stream_converted_rep(:)';
end

Eb = T / 2; % This will result in unit amplitude waveforms
carrier = sqrt(2*Eb/T) * cos(2*pi*fc*t);

bpsk_output = carrier .* bit_stream_converted_rep;

figure;
subplot(4,1,1);
plot( t , bit_stream_rep ); axis([0 T*no_bits -1.5 1.5])
title('Random BitStream')

subplot(4,1,2);
plot(t,bit_stream_converted_rep); axis([0 T*no_bits -1.5 1.5])
title('Converted BitStream')

subplot(4,1,3);
plot(t,carrier); axis([0 T*no_bits -1.5 1.5])
title('Carrier')

subplot(4,1,4);
plot(t,bpsk_output,'.'); axis([0 T*no_bits -1.5 1.5])
title('BPSK Modulated Signal')
