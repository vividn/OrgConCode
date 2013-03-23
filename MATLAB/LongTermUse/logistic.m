function logis = logistic(M)
logis = [];
for col = M; %Iterates by column
    logis = [logis 1./(1+exp(-M))];
end