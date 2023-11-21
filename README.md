# Teriyaki: A Framework to Generate Neurosymbolic PDDL-compliant Planners

### Read the paper on [ArXiv](https://arxiv.org/abs/2303.00438)

This repo contains the dataset used for the experiments and a tutorial-style Jupyter notebook with all the steps needed to fine-tune a GPT-3 model into a PDDL solver. The paper's results are also included. 

Most of the notebook's blocks should be independent from each other and are intended to be run one by one. 

If you want to run the code you will need an [OpenAI API key](https://platform.openai.com/docs/quickstart/build-your-application). Most blocks read the api key from a file ```key.txt``` located in the parent folder of the repository. You create such file with your key to quickly replicate the results without pasting your key in each block.

Each block is documented with references to the GPT-3 documentation and a basic explanation of the steps performed. GPT-3 documentation is constantly evolving thus you may encounter slight misalignements. 

**DISCLAIMER:** the project scope has grown significantly since its inception. This repo could use some reformatting and cleanup. The code should work and be clear to understand but you might encounter **cost inefficiencies** in the fine-tuning and testing procedures, duplicate code, code that is not completely parametrized and needs to be modified to perform operations on specific batches of the dataset, minor inconsistencies in the directory tree generation, etc.. 

### Contacts
[Alessio Capitanelli](mailto:alessio.capitanelli@dibris.unige.it)
