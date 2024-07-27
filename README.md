# MMSafety

## Inference Guidelines

### FigStep

```bash
python vllm_inference.py -cp conf/vllm/fig_step -cn llama3_text_test_v1_0
```

### Results

#### Text-only

|       Model        | FigStep | MM-Safety | VL-Guard | VL-Safe |
|:------------------:|:-------:|:---------:|:--------:|:-------:|
| Llama3-8b-Instruct |  71.4   |   20.71   |  19.96   |  99.28  |

