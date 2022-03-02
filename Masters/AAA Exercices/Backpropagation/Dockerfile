ARG OWNER=jupyter
ARG BASE_CONTAINER=$OWNER/minimal-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"

USER root

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    # for cython: https://cython.readthedocs.io/en/latest/src/quickstart/install.html
    build-essential \
    # for latex labels
    cm-super \
    dvipng \
    # for matplotlib anim
    ffmpeg && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mamba install --quiet --yes \
    'tensorflow' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

RUN mamba install --quiet --yes \
    'ipywidgets' \
    'pandas' \
    'numpy' \
    'dill' \
    'seaborn' \
    'scikit-learn' \
    'scipy' \
    'jupyter_bokeh' \
    'pydot' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Switch back to jovyan to avoid accidental container runs as root
USER ${NB_UID}