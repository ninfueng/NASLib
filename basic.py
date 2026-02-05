"""Workable a basic example."""

import argparse
import logging

from naslib.defaults.trainer import Trainer
from naslib.optimizers import DARTSOptimizer, Bananas
from naslib.search_spaces import NasBench201SearchSpace
from naslib.utils import (
    set_seed,
    setup_logger,
    get_config_from_args,
    get_dataset_api,
    get_last_checkpoint,
)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--nas-opt', type=str, default='bananas')
    parser.add_argument('--search-epochs', type=int, default=None)
    parser.add_argument('--eval-epochs', type=int, default=None)
    args = parser.parse_args()

    conf = get_config_from_args()
    logger = setup_logger(conf.save + '/log.log')
    logger.setLevel(logging.INFO)
    logger.info(conf)

    set_seed(conf.seed)
    conf.search.epochs = (
        conf.search.epochs if args.search_epoch is not None else args.search_epochs
    )
    conf.evaluation.epochs = (
        conf.evaluation.epochs if args.eval_epoch is not None else args.search_epochs
    )
    conf.save_arch_weights = True
    conf.search_space = 'nasbench201'
    dataset_api = get_dataset_api(conf.search_space, conf.dataset)

    search_space = NasBench201SearchSpace()

    nas_opt = args.nas_opt.lower()
    if nas_opt == 'darts':
        optimizer = DARTSOptimizer(**conf.search)
    elif nas_opt == 'bananas':
        optimizer = Bananas(conf)
    else:
        raise NotImplementedError(f'nas_opt is not supported, {nas_opt}')

    optimizer.adapt_search_space(search_space, conf.dataset, dataset_api=dataset_api)
    trainer = Trainer(optimizer, conf, lightweight_output=True)
    checkpoint = get_last_checkpoint(conf, search=False)
    trainer.search(resume_from=checkpoint)
    trainer.evaluate(dataset_api=dataset_api, resume_from=checkpoint)
