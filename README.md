# MMSafety

## Inference Guidelines

### FigStep

```bash
python vllm_inference.py -cp conf/vllm/fig_step -cn llama3_text_test_v1_0
```

### Results

#### Text-only ASR

|                    Model | FigStep | MM-Safety - RQ | MM-Safety - RQ-SD | MM-Safety - SD-TYPO+RQ | MM-Safety - SD+RQ-SD | MM-Safety - TYPO+RQ | VL-Guard | VL-Safe |
|-------------------------:|:-------:|:--------------:|:-----------------:|:----------------------:|:--------------------:|:-------------------:|:--------:|:-------:|
|     Llama3.1-8B-Instruct |  26.2   |      77.7      |       80.1        |          ---           |         ---          |         ---         |   67.8   |   0.7   |
|           w/ description |  22.8   |      ---       |        ---        |          47.0          |         70.1         |        38.3         |   57.9   |   1.4   |
|   w/ description-llava7b |  18.4   |                |                   |          60.7          |         71.4         |        65.2         |   58.0   |   1.4   |
| Mistral-7B-Instruct-v0.2 |  28.8   |      66.9      |       58.7        |          ---           |         ---          |         ---         |   30.8   |  13.2   |
|           w/ description |  39.4   |      ---       |        ---        |          55.3          |         71.1         |        49.7         |   52.9   |  15.6   |
|   w/ description-llava7b |  39.0   |                |                   |          63.8          |         67.3         |        56.3         |   50.2   |  16.3   |
|     Qwen2.5-14B-Instruct |  36.8   |      56.3      |       41.8        |          ---           |         ---          |         ---         |   17.2   |  22.3   |
|           w/ description |  38.0   |      ---       |        ---        |          58.6          |         76.2         |        56.7         |   77.2   |  41.7   |
|   w/ description-llava7b |  42.8   |                |                   |          71.7          |         77.5         |        69.3         |   76.5   |  41.3   |
|   Llama-3.1-70B-Instruct |  35.2   |      87.6      |       85.5        |          ---           |         ---          |         ---         |   71.0   |   6.2   |

[//]: # (|        Llama3-8b-Instruct        |  71.4   |     20.71      |          ---           |                  --- |         ---         |  19.96   |  99.28  |)

[//]: # (| Description + Llama3-8b-Instruct |         |      ---       |         52.44          |                31.19 |        60.89        |  27.28   |         |)

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

**Attack**

|                 Model | Acc.  | Safe-image-unsafe-instruction | safe-image-safe-instruction | unsafe-image |
|----------------------:|:-----:|:-----------------------------:|:---------------------------:|:------------:|
|         Llava-v1.5-7b | 42.62 |             12.54             |            98.57            |     9.95     |
|        Llava-v1.5-13b | 47.05 |             22.58             |            98.56            |    12.90     |
|  Llava-next-llama3-8b | 47.63 |             13.98             |            96.42            |    28.51     |
| Llava-v1.6-mistral-7b | 50.58 |             21.86             |            96.42            |    28.96     |
|     Phi-3-vision-128k | 68.10 |             43.73             |            94.98            |    64.93     |
|           InternVL-8B | 51.54 |             23.12             |            98.39            |    28.28     |
|           Qwen2-VL-7B | 54.43 |             25.63             |            97.85            |    35.97     |

##### VL-Guard - ASR

|                 Model | ASR  | Safe-image-unsafe-instruction | safe-image-safe-instruction | unsafe-image | unsafe |
|----------------------:|:----:|:-----------------------------:|:---------------------------:|:------------:|:------:|
|           InternVL-8B | 47.5 |                               |                             |              |  26.6  |
|               - Guard | 3.9  |                               |                             |              |  5.5   |
|     + sys prompt v1.0 | ---  |             62.54             |            86.56            |    36.43     |  51.0  |
|     + sys prompt v1.1 | ---  |             48.21             |            62.54            |    31.90     |  41.0  |
|  Llava-next-llama3-8b | ---  |             86.02             |            96.42            |    71.49     |  79.4  |
|               - Guard | 2.2  |                               |                             |              |  3.4   |
|     + sys prompt v1.1 | ---  |             84.22             |            95.34            |    66.97     |  76.6  | 
|        Llava-v1.5-13b | ---  |             77.42             |            98.56            |     87.1     |  81.7  |
|               - Guard | 3.5  |                               |                             |              |  5.4   |
|     + sys prompt v1.1 | ---  |             36.56             |            97.85            |    48.64     |  41.9  |
|         Llava-v1.5-7b | 57.4 |             87.46             |            98.57            |     90.5     |  88.6  |
|               - Guard | 5.4  |                               |                             |              |  8.4   |
|     + sys prompt v1.0 | ---  |             87.28             |            98.03            |    83.48     |  85.6  |
|     + sys prompt v1.1 | ---  |             51.43             |            98.75            |    42.76     |  47.6  |
| Llava-v1.6-mistral-7b | 49.4 |             78.14             |            96.42            |    71.04     |  75.0  |
|               - Guard | 2.8  |                               |                             |              |  4.4   |
|     + sys prompt v1.1 | ---  |             54.84             |            92.29            |    45.00     |  50.5  |
|           Qwen2-VL-7B | ---  |             74.37             |            97.85            |    64.03     |  69.8  |
|               - Guard | 2.0  |                               |                             |              |  3.1   |
|     + sys prompt v1.0 | ---  |             2.68              |            89.96            |    26.92     |  13.4  |

##### MM-Safety

|                                            Model | Overall Reject Rate | Illegal Activity | Hate Speech | Malware Generation | Physical Harm | Economic Harm | Fraud |  Sex  | Political Lobbying | Privacy Violence | Legal Opinion | Financial Advice | Health Consultation | Gov Decision |
|-------------------------------------------------:|:-------------------:|:----------------:|:-----------:|:------------------:|:-------------:|:-------------:|:-----:|:-----:|:------------------:|:----------------:|:-------------:|:----------------:|:-------------------:|:------------:|
|                               Llama3-8b-Instruct |        20.71        |      41.24       |    65.03    |       70.45        |     70.83     |     90.16     | 61.04 | 92.66 |       93.46        |      64.75       |     83.85     |      94.01       |         1.0         |    93.96     |
|            Llama3-8b-Instruct (w/ system prompt) |        34.17        |      71.13       |    53.37    |       43.18        |     32.64     |     11.48     | 48.70 | 10.09 |       16.99        |      41.73       |     52.31     |      13.17       |        14.68        |    41.61     |
|   Llama3-8b-Instruct SD+RQ-SD (w/ system prompt) |        47.08        |      78.35       |    58.90    |       81.81        |     49.31     |     24.59     | 51.95 | 13.76 |       23.53        |      43.17       |     66.15     |      27.54       |        49.54        |    70.47     |
|                                     ~~~~ + Guard |        47.56        |      78.35       |    58.90    |       81.81        |     52.08     |     24.59     | 51.95 | 13.76 |       24.84        |      43.88       |     66.92     |      27.54       |        49.54        |    70.47     |
| Llama3-8b-Instruct SD-TYPO+RQ (w/ system prompt) |        68.27        |      98.96       |    84.66    |       97.73        |     76.39     |     45.90     | 87.01 | 66.05 |       41.18        |      70.50       |     70.0      |      27.54       |        71.56        |    81.88     |
|                                     ~~~~ + Guard |        68.93        |      98.97       |    85.28    |       97.73        |     79.17     |     45.90     | 87.66 | 66.05 |       41.18        |      72.66       |     71.54     |      27.54       |        71.56        |    81.88     |                      
|    Llama3-8b-Instruct TYPO+RQ (w/ system prompt) |        73.93        |       100        |    92.64    |       97.72        |     83.33     |     45.90     | 93.51 | 88.99 |       38.56        |      89.93       |     76.15     |      29.34       |        73.39        |    81.88     | 
|                           Llava-v1.5-7b SD+RQ-SD |        13.39        |      28.87       |    13.50    |       15.91        |     17.36     |     8.20      | 11.04 | 7.34  |        2.61        |      18.71       |     24.62     |      14.37       |        15.60        |     3.36     |
|                         Llava-v1.5-7b SD-TYPO+RQ |        13.09        |      49.48       |    17.18    |       15.91        |     14.58     |     7.38      | 22.08 | 4.59  |        3.9         |      20.14       |     11.54     |       5.39       |        8.26         |     0.67     |
|                            Llava-v1.5-7b TYPO+RQ |        12.92        |      32.99       |    17.79    |        9.09        |     19.44     |     8.20      | 16.23 | 4.58  |        3.27        |      11.51       |      20       |       9.58       |        12.84        |     4.70     |
|                          Llava-v1.5-13b SD+RQ-SD |        12.80        |      35.05       |    10.43    |       18.18        |     17.36     |     8.20      | 13.64 | 6.42  |         0          |      12.95       |     23.85     |      13.17       |        15.60        |     3.36     |
|                        Llava-v1.5-13b SD-TYPO+RQ |        21.49        |      73.20       |    27.61    |       29.55        |     33.33     |     14.11     | 35.06 | 7.34  |        1.96        |      32.37       |     23.08     |      12.57       |        4.59         |     1.34     |
|                           Llava-v1.5-13b TYPO+RQ |        15.83        |      47.42       |    17.18    |       15.91        |     18.06     |     5.74      | 19.48 | 7.34  |        3.92        |      15.83       |     25.38     |      14,97       |        19.27        |     4.70     |
|                    Llava-next-llama3-8b SD+RQ-SD |        23.57        |      44.33       |    26.99    |       29.55        |     27.08     |     18.85     | 25.97 | 11.00 |        5.88        |      18.71       |      20       |      40.72       |        24.77        |    17.45     |
|                  Llava-next-llama3-8b SD-TYPO+RQ |        42.68        |      77.32       |    51.53    |       56.82        |     59/02     |     36.07     | 59.74 | 31.19 |        5.88        |      55.40       |     31.54     |      35.93       |        31.28        |    30.87     |
|                     Llava-next-llama3-8b TYPO+RQ |        46.19        |      83.51       |    57.06    |       68.18        |     63.89     |     39.34     | 70.13 | 32.11 |        5.88        |      56.83       |     36.92     |      40.72       |        49.45        |    28.19     |
|                   Llava-v1.6-mistral-7b SD+RQ-SD |        20.59        |      46.39       |    22.09    |       20.45        |     18.75     |     15.57     | 23.38 | 11.01 |        5.23        |      15.83       |     25.38     |      25.15       |        33.94        |    13.42     |
|                 Llava-v1.6-mistral-7b SD-TYPO+RQ |        37.79        |      77.32       |    48.47    |       59.09        |     40.27     |     26.23     | 62.34 | 22.02 |        3.92        |      51.08       |     25.38     |      27.54       |        55.05        |    19.46     |
|                    Llava-v1.6-mistral-7b TYPO+RQ |        42.38        |      92.78       |    53.37    |       63.63        |     57.64     |     29.51     | 67.53 | 25.69 |        7.19        |      55.40       |     40.00     |      25.15       |        43.12        |    18.12     |
|                       Phi-3-Vision-128k SD+RQ-SD |        68.99        |      80.41       |    85.89    |       59.09        |     64.58     |     58.20     | 72.08 | 71.56 |       51.63        |      74.82       |     69.23     |      62.28       |        84.40        |    62.41     | 
|                      Phi-3-Vision-128 SD-TYPO+RQ |        79.88        |      97.93       |    98.16    |       86.36        |     90.28     |     83.61     | 96.75 | 75.23 |       90.85        |      96.40       |     61.54     |      40.12       |        67.89        |    61.74     |
|                        Phi-3-Vision-128k TYPO+RQ |        77.86        |      94.85       |    96.93    |       84.09        |     88.89     |     75.41     | 95.45 | 53.21 |       83.01        |      97.84       |     70.77     |      46.71       |        67.89        |    59.73     |  
|                             InternVL-8B SD+RQ-SD |        31.19        |      52.58       |    36.81    |       27.27        |     38.19     |     26.23     | 44.16 | 12.84 |       10.46        |      39.57       |     32.31     |      40.12       |        28.44        |    14.09     |
|                           InternVL-8B SD-TYPO+RQ |        41.25        |      90.72       |    48.47    |         50         |     59.72     |     32.79     | 66.88 | 14.68 |       15.03        |      61.87       |     32.31     |      37.72       |        22.02        |    14.09     |
|                              InternVL-8B TYPO+RQ |        46.96        |      92.78       |    66.26    |       56.82        |     58.33     |     32.79     | 79.87 | 29.36 |       16.34        |      70.50       |     40.77     |      36.53       |        24.77        |    15.44     |
|                             Qwen2-VL-7B SD+RQ-SD |        18.93        |      47.42       |    17.18    |       25.00        |     29.17     |     17.21     | 24.68 | 8.26  |        4.58        |      19.42       |     18.46     |      19.16       |        22.94        |     5.37     |
|                           Qwen2-VL-7B SD-TYPO+RQ |        35.60        |      83.51       |    42.94    |       43.18        |     54.17     |     25.41     | 8.83  | 11.01 |        8.50        |      52.52       |     27.69     |      28.14       |        22.02        |     5.37     |
|                              Qwen2-VL-7B TYPO+RQ |        39.64        |      89.69       |    56.44    |       50.00        |     55.56     |     25.41     | 79.22 | 19.27 |        5.88        |      66.19       |     32.31     |      19.76       |        21.10        |     8.05     |

###### MM-Safety SD+RQ-SD ASR

|                 Model | ASR  | Illegal Activity | Hate Speech | Malware Generation | Physical Harm | Economic Harm | Fraud | Sex  | Political Lobbying | Privacy Violence | Legal Opinion | Financial Advice | Health Consultation | Gov Decision |
|----------------------:|:----:|:----------------:|:-----------:|:------------------:|:-------------:|:-------------:|:-----:|:----:|:------------------:|:----------------:|:-------------:|:----------------:|:-------------------:|:------------:|
|          InternVL2-8B | 68.8 |       47.7       |    63.2     |        72.7        |     61.8      |     73.8      | 55.8  | 87.2 |        89.5        |       60.4       |     67.7      |       59.9       |        71.6         |     85.9     | 
|               - Guard | 8.5  |       11.3       |     8.6     |        11.4        |     17.4      |      1.6      | 14.3  | 3.7  |        0.0         |       11.5       |     16.2      |       4.2        |        13.8         |     0.0      |
|  Llava-next-llama3-8b | 74.6 |       48.5       |    72.4     |        77.3        |     67.4      |     79.5      | 72.8  | 84.4 |        95.4        |       79.9       |     73.1      |       64.1       |        71.6         |     79.9     |
|               - Guard | 9.0  |       22.7       |    10.4     |        18.2        |     22.2      |      2.5      | 19.5  | 0.0  |        0.0         |       19.5       |      3.1      |       3.0        |         2.8         |     0.0      |
|        Llava-v1.5-13b | 86.1 |       63.9       |    87.7     |        79.5        |     81.2      |     91.8      | 83.8  | 92.7 |        98.7        |       86.3       |     80.0      |       86.2       |        79.8         |     95.3     |
|               - Guard | 12.2 |       28.9       |    18.4     |        13.6        |     25.0      |      3.3      | 31.2  | 3.7  |        0.7         |       25.2       |      5.4      |       1.2        |         3.7         |     0.0      |
|         Llava-v1.5-7b | 88.0 |       70.1       |    87.7     |        84.1        |     85.4      |     93.4      | 85.1  | 94.5 |        98.7        |       89.9       |     76.2      |       88.6       |        85.3         |     96.0     |
|               - Guard | 13.0 |       29.9       |    21.5     |        20.5        |     27.1      |      2.5      | 30.5  | 2.8  |        0.0         |       24.5       |      5.4      |       2.4        |         7.3         |     0.0      |
| Llava-v1.6-mistral-7b | 78.6 |       56.7       |    73.6     |        77.3        |     79.2      |     81.1      | 79.2  | 88.1 |        93.5        |       78.5       |     76.9      |       75.4       |        67.0         |     86.6     |
|               - Guard | 9.3  |       25.8       |    13.5     |        13.6        |     22.2      |      2.5      | 26.0  | 0.0  |        0.0         |       16.5       |      1.5      |       1.2        |         0.9         |     0.0      |
|           Qwen2-VL-7B | 81.1 |       52.6       |    82.8     |        75.0        |     70.8      |     82.8      | 75.3  | 91.7 |        95.4        |       80.6       |     81.5      |       80.8       |        77.1         |     94.6     |
|               - Guard | 8.5  |       17.5       |     9.2     |        11.4        |     22.2      |      0.8      | 16.2  | 1.8  |        0.7         |       17.3       |      5.4      |       3.0        |         7.3         |     0.0      |

###### MM-Safety SD+Typo-RQ ASR

|                 Model | ASR  | Illegal Activity | Hate Speech | Malware Generation | Physical Harm | Economic Harm | Fraud | Sex  | Political Lobbying | Privacy Violence | Legal Opinion | Financial Advice | Health Consultation | Gov Decision |
|----------------------:|:----:|:----------------:|:-----------:|:------------------:|:-------------:|:-------------:|:-----:|:----:|:------------------:|:----------------:|:-------------:|:----------------:|:-------------------:|:------------:|
|          InternVL2-8B | 58.7 |       9.3        |    51.5     |        50.0        |     40.3      |     67.2      | 33.1  | 85.3 |        85.0        |       38.1       |     67.7      |       62.3       |        77.0         |     84.9     |
|               - Guard | 25.6 |       37.1       |    27.0     |        63.6        |     50.7      |     11.5      | 52.6  | 20.2 |        2.0         |       46.0       |     23.8      |       8.4        |        18.3         |     0.0      |
|  Llava-next-llama3-8b | 56.8 |       20.6       |    53.4     |        43.2        |     40.3      |     65.6      | 29.9  | 66.1 |        93.5        |       45.3       |     68.5      |       64.7       |        56.0         |     73.2     |
|               - Guard | 23.0 |       55.7       |    28.8     |        50.0        |     47.9      |      8.2      | 54.5  | 15.6 |        0.0         |       44.6       |      5.4      |       4.2        |         6.4         |     0.0      |
|        Llava-v1.5-13b | 77.4 |
|               - Guard | 29.5 |
|         Llava-v1.5-7b | 86.8 |
|               - Guard | 29.9 |
| Llava-v1.6-mistral-7b | 62.3 |
|               - Guard | 27.3 |
|           Qwen2-VL-7B | 64.4 |
|               - Guard | 36.7 |

###### MM-Safety Typo+RQ ASR

|                 Model | ASR  | Illegal Activity | Hate Speech | Malware Generation | Physical Harm | Economic Harm | Fraud | Sex | Political Lobbying | Privacy Violence | Legal Opinion | Financial Advice | Health Consultation | Gov Decision |
|----------------------:|:----:|:----------------:|:-----------:|:------------------:|:-------------:|:-------------:|:-----:|:---:|:------------------:|:----------------:|:-------------:|:----------------:|:-------------------:|:------------:|
|          InternVL2-8B | 53.0 |
|               - Guard | 26.5 |
|  Llava-next-llama3-8b | 53.8 |
|               - Guard | 25.4 |
|        Llava-v1.5-13b | 84.2 |
|               - Guard | 12.2 |
|         Llava-v1.5-7b | 87.1 |
|               - Guard | 12.0 |
| Llava-v1.6-mistral-7b | 57.6 |
|               - Guard | 25.4 |
|           Qwen2-VL-7B | 60.4 |
|               - Guard | 24.0 |

###### MM-Safety Text-only RQ

|                           Model |  ASR  |
|--------------------------------:|:-----:|
|             Llava-v1.5-7b-mixed | 7.98  |
|                     dummy image |  0.1  |
|           Llava-v1.5-7b-posthoc | 5.60  |
|                     dummy image |  0.2  |
|            Llava-v1.5-13b-mixed | 15.77 |
|                     dummy image |  0.1  |
|          Llava-v1.5-13b-posthoc | 3.15  |
|                     dummy image |  0.1  |
|                   Llava-v1.5-7b | 41.9  |
|                     dummy image | 83.21 |
|               + sys prompt v1.1 | 0.12  |
| + sys prompt v2.0 - dummy image | 51.96 |
|                  Llava-v1.5-13b | 32.3  |
|                     dummy image | 81.85 |
|               + sys prompt v1.1 | 5.42  |
| + sys prompt v2.0 - dummy image | 42.38 |
|                    IntervnVL-8B | 4.17  |
|               + sys prompt v1.1 |  0.0  |
|                     dummy image | 25.54 |
| + sys prompt v2.0 + dummy image |  0.0  |
|               Llava-next-llama3 |       |
|                     dummy image | 97.56 |
| + sys prompt v2.0 - dummy image | 81.90 |
|     Llava-v1.6-mistral-7b-mixed |       |
|                     dummy image | 96.55 |
| + sys prompt v2.0 - dummy image | 4.88  |
|                        Qwen2-VL |       |
|                     dummy image | 5.18  |
| + sys prompt v2.0 - dummy image | 2.38  |

###### MM-Safety Text-only RQ-SD

|                           Model |  ASR  |
|--------------------------------:|:-----:|
|             Llava-v1.5-7b-mixed | 7.56  |
|                     dummy image |  0.1  |
|           Llava-v1.5-7b-posthoc | 6.01  |
|                    dummy iumage |  0.1  |
|            Llava-v1.5-13b-mixed | 9.29  |
|                     dummy image |  0.1  |
|          Llava-v1.5-13b-posthoc | 1.90  |
|                     dummy image |  0.1  | 
|                   Llava-v1.5-7b | 33.99 |
|               + sys prompt v1.1 |  0.0  |
|                     dummy image | 83.04 |
| + sys prompt v2.0 - dummy image | 46.42 |
|                  Llava-v1.5-13b | 25.18 |
|               + sys prompt v1.1 | 11.07 |
|                     dummy image | 87.74 |
| + sys prompt v2.0 - dummy image | 66.07 |
|            llava-next-llama3-8b |       |
|                     dummy image | 98.21 |
| + sys prompt v2.0 - dummy image | 85.95 |
|     Llava-v1.6-mistral-7b-mixed |       |
|                     dummy image | 94.46 |
| + sys prompt v2.0 - dummy image | 2.68  |
|                    IntervnVL-8B |       |
|                     dummy image | 26.49 |
| + sys prompt v2.0 - dummy image | 0.18  |
|                        QwenVL-2 |       |
|                     dummy image | 7.32  |
| + sys prompt v2.0 - dummy image |  0.2  |

##### FigStep

|                 Model | Overall | Illegal Activity | Hate Speech | Malware Generation | Physical Harm | Fraud | Adult Content | Privacy Violation | Legal Opinion | Financial Advice | Health Consultation | 
|----------------------:|:-------:|:----------------:|:-----------:|:------------------:|:-------------:|:-----:|:-------------:|:-----------------:|:-------------:|:----------------:|:-------------------:|
|         Llava-v1.5-7b |  34.40  |      52.00       |    50.00    |       58.00        |     38.00     | 42.00 |     20.00     |       26.00       |     14.00     |      18.00       |        26.00        |
|        Llava-v1.5-13b |  46.80  |       72.0       |    62.0     |        76.0        |     60.0      | 52.0  |     24.0      |       42.0        |     22.0      |       20.0       |        38.0         |
|  Llava-next-llama3-8b |  51.6   |       72.0       |    50.0     |        80.0        |     76.0      | 76.0  |     26.0      |       42.0        |     28.0      |       36.0       |        30.0         |
| Llava-v1.6-mistral-7b |  49.8   |       84.0       |    70.0     |        80.0        |     66.0      | 74.0  |     28.0      |       42.0        |     16.0      |       22.0       |        16.0         |
|           InternVL-8B |  54.2   |       56.0       |    86.0     |        84.0        |     70.0      | 82.0  |     16.0      |       66.0        |     26.0      |       22.0       |        34.0         | 
|   InternVL-8B - Guard |  74.4   |       72.0       |    90.0     |        60.0        |     54.0      | 74.0  |     80.0      |       82.0        |     74.0      |       82.0       |        76.0         |
|     Phi-3-vision-128k |  89.2   |       94.0       |    100.0    |        96.0        |     82.0      | 86.0  |     70.0      |       96.0        |     72.0      |       88.0       |        88.0         |
|           Qwen2-VL-7B |  67.8   |       86.0       |    90.0     |        90.0        |     92.0      | 92.0  |     32.0      |       84.0        |     34.0      |       22.0       |        56.0         |

###### ASR (1 - acc_rate)

|                         Model | Overall | Illegal Activity | Hate Speech | Malware Generation | Physical Harm | Fraud | Adult Content | Privacy Violation | Legal Opinion | Financial Advice | Health Consultation | 
|------------------------------:|:-------:|:----------------:|:-----------:|:------------------:|:-------------:|:-----:|:-------------:|:-----------------:|:-------------:|:----------------:|:-------------------:|
|                 Llava-v1.5-7b |  65.6   |       48.0       |    50.0     |        42.0        |     62.0      | 58.0  |     80.0      |       74.0        |     86.0      |       82.0       |        74.0         |
|         Llava-v1.5-7b - Guard |  42.6   |       62.0       |    30.0     |        80.0        |     82.0      | 76.0  |     18.0      |       42.0        |     18.0      |       14.0       |         4.0         |
|                Llava-v1.5-13b |  53.2   |       28.0       |    38.0     |        24.0        |     40.0      | 48.0  |     76.0      |       58.0        |     78.0      |       80.0       |        62.0         |
|        Llava-v1.5-13b - Guard |  34.2   |       48.0       |    10.0     |        62.0        |     64.0      | 66.0  |     14.0      |       30.0        |     24.0      |       16.0       |         8.0         |
|          Llava-next-llama3-8b |  48.4   |       28.0       |    50.0     |        20.0        |     24.0      | 24.0  |     74.0      |       58.0        |     72.0      |       64.0       |        70.0         |
|  Llava-next-llama3-8b - Guard |  58.8   |       80.0       |    72.0     |        92.0        |     94.0      | 78.0  |     28.0      |       72.0        |     10.0      |       18.0       |        34.0         |
|         Llava-v1.6-mistral-7b |  50.2   |       16.0       |    30.0     |        20.0        |     34.0      | 26.0  |     72.0      |       58.0        |     84.0      |       78.0       |        84.0         |
| Llava-v1.6-mistral-7b - Guard |  15.0   |       38.0       |     2.0     |        28.0        |     14.0      | 26.0  |     16.0      |       10.0        |     12.0      |       4.0        |         0.0         |
|                   InternVL-8B |  45.8   |       44.0       |    14.0     |        16.0        |     30.0      | 18.0  |     84.0      |       34.0        |     74.0      |       78.0       |        66.0         | 
|           InternVL-8B - Guard |  35.6   |       28.0       |    10.0     |        40.0        |     46.0      | 26.0  |     20.0      |       18.0        |     26.0      |       18.0       |        24.0         |
|                   Qwen2-VL-7B |  32.2   |       14.0       |    10.0     |        10.0        |      8.0      |  8.0  |     68.0      |       16.0        |     66.0      |       78.0       |        44.0         |
|           Qwen2-VL-7B - Guard |  58.6   |       74.0       |    66.0     |        90.0        |     92.0      | 86.0  |     24.0      |       72.0        |     10.0      |       34.0       |        38.0         |

##### VL-Safe

|                 Model | Acc.  | 
|----------------------:|:-----:|
|         Llava-v1.5-7b | 41.72 | 
|        Llava-v1.5-13b | 41.53 |  
|  Llava-next-llama3-8b | 53.06 |   
| Llava-v1.6-mistral-7b | 84.59 |
|           Qwen2-VL-7B | 50.54 |
|     Phi-3-vision-128k | 80.36 |
|           InternVL-8B | 74.59 |

##### VL-Safe ASR

|                 Model | Acc. | 
|----------------------:|:----:|
|           InternVL-8B | 25.9 |
|               - Guard | 36.8 |
|  Llava-next-llama3-8b | 46.9 | 
|               - Guard | 24.8 |
|        Llava-v1.5-13b | 58.5 |  
|               - Guard | 38.8 |
|         Llava-v1.5-7b | 58.3 |
|               - Guard | 75.5 |
| Llava-v1.6-mistral-7b | 15.4 | 
|               - Guard | 43.4 |
|           Qwen2-VL-7B | 49.5 |
|               — Guard | 15.4 |

#### Description - LLama-3-Guard-Evaluation

|         Model         | FigStep | MM-Safety - SD | MM-Safety - SD-TYPO | MM-Safety - TYPO | VL-Guard | VL-Safe |
|:---------------------:|:-------:|:--------------:|:-------------------:|-----------------:|:--------:|:-------:|
|     InternVL2-8B      |  63.4   |     99.88      |        98.99        |            98.39 |  98.20   |  99.90  |
| Llava-next-llama3-8b  |  76.0   |      1.0       |        99.94        |            99.58 |   99.0   |  100.0  |
|    Llava-v1.5-13b     |  75.0   |     99.94      |        99.70        |            99.94 |   99.8   |  100.0  |
|     Llava-v1.5-7b     |  94.6   |     99.94      |        99.76        |            100.0 |  100.0   |  100.0  | 
| llava-v1.6-mistral-7b |  82.4   |     99.94      |        99.41        |            99.94 |   98.9   |  100.0  |
|      Qwen2-VL-7B      |  82.0   |     100.0      |        99.64        |            99.52 |   99.1   |  100.0  |

#### Description - Keywords - ASR

|                 Model | FigStep | MM-Safety - SD | MM-Safety - SD-TYPO | MM-Safety - TYPO | VL-Guard Safe Image | VL-Guard Unsafe Image | VL-Safe |
|----------------------:|:-------:|:--------------:|:-------------------:|-----------------:|:-------------------:|:---------------------:|:-------:|
|    Llava-1.5-7b-mixed |         |                |                     |                  |        20.97        |         2.04          |         |
|  Llava-1.5-7b-posthoc |         |                |                     |                  |        16.30        |         1.36          |         |
| Llava-1.5-13b-posthoc |         |                |                     |                  |        43.18        |         12.90         |         |
|   Llava-1.5-13b-mixed |         |                |                     |                  |        43.91        |         7.24          |         |
|         Llava-v1.5-7b |         |                |                     |                  |        100.0        |         100.0         |         | 
|       + system prompt |         |                |                     |                  |        99.28        |         99.55         |         |
|     + sys prompt v2.1 |         |                |                     |                  |        13.08        |         23.08         |         |
|        Llava-v1.5-13b |         |                |                     |                  |        99.82        |         100.0         |         |
|       + system prompt |         |                |                     |                  |        100.0        |         100.0         |         |
|     + sys prompt v2.1 |         |                |                     |                  |        2.86         |         2.26          |         |
|            InterVL-8B |         |                |                     |                  |        98.57        |         97.29         |         |
|       + system prompt |         |                |                     |                  |        46.78        |         37.56         |         |
|     + sys prompt v2.1 |         |                |                     |                  |        37.81        |         15.61         |         |
| Llava-v1.6-mistral-7B |         |                |                     |                  |        100.0        |         99.10         |         |
|       + system prompt |         |                |                     |                  |        99.64        |         98.87         |         |
|     + sys prompt v2.1 |         |                |                     |                  |        34.77        |         32.58         |         |
|  Llava-next-llama3-8b |         |                |                     |                  |        99.28        |         99.32         |         |
|       + system prompt |         |                |                     |                  |        99.64        |         99.55         |         |
|     + sys prompt v2.1 |         |                |                     |                  |        40.14        |         40.27         |         |
|           QwenVL-2-7B |         |                |                     |                  |        99.46        |         99.55         |         |
|       + system prompt |         |                |                     |                  |        98.92        |         85.29         |         |
|     + sys prompt v2.1 |         |                |                     |                  |        92.11        |         80.32         |         |

##### Caption Prompt 1

|         Model         | FigStep | MM-Safety - SD | MM-Safety - SD-TYPO | MM-Safety - TYPO | VL-Guard Safe Image | VL-Guard Unsafe Image | VL-Safe |
|:---------------------:|:-------:|:--------------:|:-------------------:|-----------------:|:-------------------:|:---------------------:|:-------:|
|  Llava-1.5-7b-mixed   |         |                |                     |                  |        40.86        |         10.86         |         |
| Llava-1.5-7b-posthoc  |         |                |                     |                  |        85.13        |         62.67         |         |
| Llava-1.5-13b-posthoc |         |                |                     |                  |        89.07        |         56.79         |         |
|  Llava-1.5-13b-mixed  |         |                |                     |                  |        89.96        |         52.49         |         |

##### Caption Prompt 2

|         Model         | FigStep | MM-Safety - SD | MM-Safety - SD-TYPO | MM-Safety - TYPO | VL-Guard Safe Image | VL-Guard Unsafe Image | VL-Safe |
|:---------------------:|:-------:|:--------------:|:-------------------:|-----------------:|:-------------------:|:---------------------:|:-------:|
|  Llava-1.5-7b-mixed   |         |                |                     |                  |        99.46        |         85.97         |         |
| Llava-1.5-7b-posthoc  |         |                |                     |                  |        99.83        |         99.32         |         |
| Llava-1.5-13b-posthoc |         |                |                     |                  |        99.82        |         99.77         |         |
|  Llava-1.5-13b-mixed  |         |                |                     |                  |        99.10        |         87.56         |         |

#### OCR - GPT-4o

|     Model     | FigStep | MM-Safety - SD | MM-Safety - SD-TYPO | MM-Safety - TYPO | VL-Guard | VL-Safe |
|:-------------:|:-------:|:--------------:|:-------------------:|-----------------:|:--------:|:-------:|
| Llava-v1.5-7b |  65.8   |                |        92.86        |                  |          |         |

#### OCR - LLama-3-Guard-Evaluation

|         Model         | FigStep | VL-Guard | MM-Safety - SD-TYPO |
|:---------------------:|:-------:|:--------:|:-------------------:|
|     InternVL2-8B      |  66.6   |  89.37   |        98.99        |
| Llava-next-llama3-8b  |  75.6   |  98.19   |        99.76        |
|    Llava-v1.5-13b     |  83.2   |  99.32   |        99.11        |
|     Llava-v1.5-7b     |  68.0   |  97.96   |        96.96        |
| llava-v1.6-mistral-7b |  88.2   |  98.19   |        99.28        |
|      Qwen2-VL-7B      |  67.2   |  96.15   |        96.01        |

### VL-Guard Checkpoint Inference

|         Model          | FigStep | MM-Safety - SD + RQ-SD | MM-Safety - SD + TYPO-RQ | MM-Safety - TYPO + RQ | VL-Guard (Safe) | VL-Guard (unsafe ins.) | VL-Guard (unsafe img.) | VL-Safe |
|:----------------------:|:-------:|:----------------------:|:------------------------:|:---------------------:|:---------------:|:-----------------------|:----------------------:|:-------:|
|  Llava-v1.5-7b-mixed   |   2.2   |          0.00          |           0.00           |         0.00          |      7.71       | 0.72                   |          0.23          |  2.89   |
| Llava-v1.5-7b-posthoc  |   6.8   |          0.12          |           1.02           |         0.12          |      5.74       | 0.90                   |          0.00          |  2.35   |
|  Llava-v1.5-13b-mixed  |   2.8   |          0.18          |           0.12           |         0.06          |      9.68       | 0.36                   |          0.23          |  1.99   |
| Llava-v1.5-13b-posthoc |   3.6   |          0.24          |           0.18           |         0.18          |      8.43       | 0.72                   |          2.04          |  1.27   |

### Keywords Hack

#### FigStep

##### Original

|                         Model | ASR  | Illegal Activity | Hate Speech | Malware Generation | Physical Harm | Fraud | Adult Content | Privacy Violation | Legal Opinion | Financial Advice | Health Consultation | 
|------------------------------:|:----:|:----------------:|:-----------:|:------------------:|:-------------:|:-----:|:-------------:|:-----------------:|:-------------:|:----------------:|:-------------------:|
|                 Llava-v1.5-7b | 65.6 |       48.0       |    50.0     |        42.0        |     62.0      | 58.0  |     80.0      |       74.0        |     86.0      |       82.0       |        74.0         |
|         Llava-v1.5-7b - Guard | 42.6 |       62.0       |    30.0     |        80.0        |     82.0      | 76.0  |     18.0      |       42.0        |     18.0      |       14.0       |         4.0         |
|                Llava-v1.5-13b | 53.2 |       28.0       |    38.0     |        24.0        |     40.0      | 48.0  |     76.0      |       58.0        |     78.0      |       80.0       |        62.0         |
|        Llava-v1.5-13b - Guard | 34.2 |       48.0       |    10.0     |        62.0        |     64.0      | 66.0  |     14.0      |       30.0        |     24.0      |       16.0       |         8.0         |
|          Llava-next-llama3-8b | 48.4 |       28.0       |    50.0     |        20.0        |     24.0      | 24.0  |     74.0      |       58.0        |     72.0      |       64.0       |        70.0         |
|  Llava-next-llama3-8b - Guard | 58.8 |       80.0       |    72.0     |        92.0        |     94.0      | 78.0  |     28.0      |       72.0        |     10.0      |       18.0       |        34.0         |
|         Llava-v1.6-mistral-7b | 50.2 |       16.0       |    30.0     |        20.0        |     34.0      | 26.0  |     72.0      |       58.0        |     84.0      |       78.0       |        84.0         |
| Llava-v1.6-mistral-7b - Guard | 15.0 |       38.0       |     2.0     |        28.0        |     14.0      | 26.0  |     16.0      |       10.0        |     12.0      |       4.0        |         0.0         |
|                   InternVL-8B | 45.8 |       44.0       |    14.0     |        16.0        |     30.0      | 18.0  |     84.0      |       34.0        |     74.0      |       78.0       |        66.0         | 
|           InternVL-8B - Guard | 35.6 |       28.0       |    10.0     |        40.0        |     46.0      | 26.0  |     20.0      |       18.0        |     26.0      |       18.0       |        24.0         |
|                   Qwen2-VL-7B | 32.2 |       14.0       |    10.0     |        10.0        |      8.0      |  8.0  |     68.0      |       16.0        |     66.0      |       78.0       |        44.0         |
|           Qwen2-VL-7B - Guard | 58.6 |       74.0       |    66.0     |        90.0        |     92.0      | 86.0  |     24.0      |       72.0        |     10.0      |       34.0       |        38.0         |

##### With "I'm sorry"

|                 Model | ASR |
|----------------------:|:---:|
|         Llava-v1.5-7b | 0.0 |
|        Llava-v1.5-13b | 0.8 |
| Llava-v1.6-mistral-7b | 0.0 |
|  Llava-next-llama3-8b | 0.0 |
|           Qwen2-VL-7B | 0.6 |
|           InternVL-8B | 0.0 |

#### MM-Vet

|                Model |  ASR  |
|---------------------:|:-----:|
|        Llava-v1.5-7b | 26.61 |
|       Llava-v1.5-13b | 49.54 |
|   Llava-v1.6-mistral | 20.18 |
| Llava-next-llama3-8b | 20.64 |
|          Qwen2-VL-7B | 50.0  | 
|          InternVL-8B |  0.5  |

#### MM-Vet VQA

|              Model | Acc. |
|-------------------:|:----:|
|      Llava-v1.5-7b | 29.1 |
|            w/ hack | 12.9 |
| Llava-v1.6-mistral | 38.4 |
|            w/ hack | 24.9 |
|       InternVL2-8B | 45.4 |
|            w/ hack | 45.2 |





