x = [
    23 34 534
    43 434 43
    343 43 32
    34 54 2 
    34 5 66
    ];

[coeff, score, latent] = princomp(x);
[d, e] = fastPCA(x, 3); % 主成分分析PCA
display(coeff);
display('..................');
display(score);
display('..................');
display(latent);
display('..................');
display(d);
display('..................');
display(e);
display('..................');