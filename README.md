# shiny-eGFR

As a former lifelong patient with chronic kidney disease, eGFR was the bane of my existence. But now, as a kidney transplant recipient, I decided to create a simple calculator in Shiny. This app allows you to calculate eGFR based on different parameters and offers the flexibility to fork and customize it to your specific needs. Unlike online calculators, this app can be used offline by downloading and running it in RStudio.

This Shiny app calculates the estimated Glomerular Filtration Rate (eGFR) using the CKD-EPI (2021) formula by Inker et al., (2021). The equation is given as: 

$$
eGFR = 142 \times \min\left(\frac{Scr}{K}, 1\right)^\alpha \times \max\left(\frac{Scr}{K}, 1\right)^{-1.200} \times 0.9938^{Age} \times 1.012 \text{ [if female]}
$$

Where:
* **eGFR** (estimated Glomerular Filtration Rate) is the calculated result, representing the rate of blood flow through the kidneys. It's expressed in mL/min/1.73 m<sup>2</sup> and is represented as ```eGFR``` in the code.
* **Scr** (Serum Creatinine) is a waste product from muscle metabolism, measured in mg/dL. In the code, it's represented as ```creatinine```.
* **K** is a constant which varies based on the patient's sex: 0.7 for females, and 0.9 for males. In the code, it's represented as ```kappa```.
* **α** is another constant that varies based on sex: -0.241 for females, and -0.302 for males. In the code, it's represented as ```alpha```. 
* **min** indicates the minimum of Scr/K or 1. In the equation, Scr/K represents the ratio of the Serum Creatinine (Scr) to the sex-based constant (K).  Represented as ```min_value```.
* **max** indicates the maximum of Scr/K or 1. Similar to above, this represents the maximum of the Scr/K ratio or 1 that is used in the calculation. Represented as ```max_value```.

<p align="center">
  <img src="https://github.com/sentfromthehub/shiny-eGFR/assets/121725874/f1cb855f-3677-40e9-b86c-29ac4d399523" alt="CKD Classification" width="500"/>
</p>

<p align="center" style="font-size: 0.8em;">
  <strong>Figure 1:</strong> Prognosis of CKD by GFR and albuminuria categories. Green, low risk of disease progression; yellow, moderately increased risk of disease progression; orange, high risk of disease progression; red, very high risk of disease progression (Levin et al., 2013).
</p>

Chronic Kidney Disease (CKD) can be classified into several categories based on the eGFR. The 2012 Kidney Disease: Improving Global Outcomes (KDIGO) classification provides a guideline for this categorization which has been implemented in the app:

1. ${\color{green} eGFR > 90}$: Normal or high
2. ${\color{yellow} 60 < eGFR \leq 90}$: Mildly decreased
3. ${\color{orange} 45 < eGFR \leq 60}$: Mildly to moderately decreased
4. ${\color{red} 30 < eGFR \leq 45}$: Moderately to severely decreased
5. ${\color{darkred} 15 < eGFR \leq 30}$: Severely decreased
6. ${\color{black} eGFR < 15}$: Kidney failure


## Progress Screenshots

![image](https://github.com/sentfromthehub/shiny-eGFR/assets/121725874/2c54f491-bcd8-475b-bc00-dbffd28843dd)
![image](https://github.com/sentfromthehub/shiny-eGFR/assets/121725874/67aa2ae2-0642-4217-ae55-390fb7c24b65)


## References

Inker, L. A., Eneanya, N. D., Coresh, J., Tighiouart, H., Wang, D., Sang, Y., Crews, D. C., Doria, A., Estrella, M. M., Froissart, M., Grams, M. E., Greene, T., Grubb, A., Gudnason, V., Gutiérrez, O. M., Kalil, R., Karger, A. B., Mauer, M., Navis, G., … Chronic Kidney Disease Epidemiology Collaboration. (2021). New creatinine- and cystatin c-based equations to estimate gfr without race. The New England Journal of Medicine, 385(19), 1737–1749. https://doi.org/10.1056/NEJMoa2102953

Levin A, Stevens PE, Bilous RW, et al. Kidney Disease: Improving Global Outcomes (KDIGO) CKD work group. KDIGO 2012 clinical practice guideline for the evaluation and management of chronic kidney disease. Kidney Int Suppl. 2013;3:1–150.
