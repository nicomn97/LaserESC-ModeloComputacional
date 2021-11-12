load('Registros/curvaAbsSat.mat');    %Carga datos de curva de absorción
fSamp=6500;                 %Frecuencia de sampleo (Hz)
tSamp=1/fSamp;              %Tiempo de sampleo (s)

Nu0R=10;                   %Offset inicial en frecuencia optica con respecto a Nu_ref (Hz)
Nu0=Nu0R;                   %Frecuencia óptica inicial (Hz)

Aesc=0.12;                   %Amplitud de modulación para ESC
fmod=140;                    %Frecuencia de modulación para ESC (Hz)
tauLock=300e-3;               %Tiempo de integracion en Lock-In
nCut=round(tauLock*fSamp);      %Numero de datos acumulados en demodulación
paramIntegral=ones(1,nCut);
tInitPID=1;            %Tiempo de inicio de PID
Slock=1500;            %Sensitividad de Lock In

tSim=60*2;

Cpzt=33;       % (MHz/V)
Ci=-215;       % (MHz/V)

tDAQ=0.180;
P=-3.2;
I=95;

out = sim('laserESClazoAbierto',tSim);

results = array2table([out.desarrolloFrecuencia.Time, out.desarrolloFrecuencia.Data, out.desarrolloVoltaje.Data, out.SalidaLockIn.Data, out.SalidaPI.Data]);
results.Properties.VariableNames(1:5) = {'t','nu','Vpd','Verr','Vpi'};
writetable(results,'Registros/datosMatlab.csv')