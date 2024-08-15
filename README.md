# MMSafety

## Inference Guidelines

### FigStep

```bash
python vllm_inference.py -cp conf/vllm/fig_step -cn llama3_text_test_v1_0
```

### Results

#### Text-only

|              Model               | FigStep | MM-Safety - RQ | MM-Safety - SD-TYPO+RQ | MM-Safety - SD+RQ-SD | MM-Safety - TYPO+RQ | VL-Guard | VL-Safe |
|:--------------------------------:|:-------:|:--------------:|:----------------------:|---------------------:|:-------------------:|:--------:|:-------:|
|        Llama3-8b-Instruct        |  71.4   |     20.71      |          ---           |                  --- |         ---         |  19.96   |  99.28  |
| Description + Llama3-8b-Instruct |         |      ---       |         52.44          |                31.19 |        60.89        |  27.28   |         |

----

##### VL-Guard

- Llama-3-8b-Instruct
    - Text-only
        - Overall Acc.: 54.11
        - Safe-image-safe-instruction Acc.: 97.67
        - Safe-image-unsafe-instruction Acc.: 18.10
        - Unsafe-image: 44.57
    - Description + Text
        - Overall Acc.: 60.08
        - Safe-image-safe-instruction Acc.: 97.31
        - Safe-image-unsafe-instruction Acc.: 27.59
        - Unsafe-image: 54.07

##### MM-Safety

|                      Model                       | Overall Reject Rate | Illegal Activity | Hate Speech | Malware Generation | Physical Harm | Economic Harm | Fraud |  Sex  | Political Lobbying | Privacy Violence | Legal Opinion | Financial Advice | Health Consultation | Gov Decision |
|:------------------------------------------------:|:-------------------:|:----------------:|:-----------:|:------------------:|:-------------:|:-------------:|:-----:|:-----:|:------------------:|:----------------:|:-------------:|:----------------:|:-------------------:|:------------:|
|                Llama3-8b-Instruct                |        20.71        |      41.24       |    65.03    |       70.45        |     70.83     |     90.16     | 61.04 | 92.66 |       93.46        |      64.75       |     83.85     |      94.01       |         1.0         |    93.96     |
|      Llama3-8b-Instruct (w/ system prompt)       |        34.17        |      71.13       |    53.37    |       43.18        |     32.64     |     11.48     | 48.70 | 10.09 |       16.99        |      41.73       |     52.31     |      13.17       |        14.68        |    41.61     |
|  Llama3-8b-Instruct SD+RQ-SD (w/ system prompt)  |        47.08        |      78.35       |    58.90    |       81.81        |     49.31     |     24.59     | 51.95 | 13.76 |       23.53        |      43.17       |     66.15     |      27.54       |        49.54        |    70.47     |
|                   ~~~~ + Guard                   |        47.56        |      78.35       |    58.90    |       81.81        |     52.08     |     24.59     | 51.95 | 13.76 |       24.84        |      43.88       |     66.92     |      27.54       |        49.54        |    70.47     |
| Llama3-8b-Instruct SD-TYPO+RQ (w/ system prompt) |        68.27        |      98.96       |    84.66    |       97.73        |     76.39     |     45.90     | 87.01 | 66.05 |       41.18        |      70.50       |     70.0      |      27.54       |        71.56        |    81.88     |
|                   ~~~~ + Guard                   |        68.93        |      98.97       |    85.28    |       97.73        |     79.17     |     45.90     | 87.66 | 45.90 |       87.66        |      66.05       |     41.18     |      72.66       |        71.54        |    27.54     | 71.56 |81.88|                      
|  Llama3-8b-Instruct TYPO+RQ (w/ system prompt)   |        73.93        |       100        |    92.64    |       97.72        |     83.33     |     45.90     | 93.51 | 88.99 |       38.56        |      89.93       |     76.15     |      29.34       |        73.39        |    81.88     | 