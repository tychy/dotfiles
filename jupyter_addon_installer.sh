# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | basho
pip install jupyter jupyterlab autopep8
#jupyter
jupyter labextension install @lckr/jupyterlab_variableinspector

pip install jupyterlab_code_formatter
jupyter labextension install @ryantam626/jupyterlab_code_formatter
jupyter serverextension enable --py jupyterlab_code_formatter

upyter labextension install jupyterlab_vim

jupyter labextension install @jupyterlab/git
pip install jupyterlab-git
jupyter serverextension enable --py jupyterlab_git

pip install ipywidgets
jupyter labextension install @jupyter-widgets/jupyterlab-manager
jupyter nbextension enable --py --sys-prefix widgetsnbextension

