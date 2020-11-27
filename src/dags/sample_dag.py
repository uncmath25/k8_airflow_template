from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from datetime import datetime, timedelta
from time import sleep


default_args = {
    'owner': 'airflow',
    'email': ["coltonwillig@gmail.com"],
    'email_on_failure': True,
    'email_on_retry': False,
    'start_date': datetime(2020, 11, 27),
    'depends_on_past': True,
    'retries': 1,
    'retry_delay': timedelta(minutes=1),
    'max_active_runs': 1,
    'execution_timeout': timedelta(hours=4)
}

dag = DAG('sample',
          default_args=default_args,
          schedule_interval='@daily',
          catchup=False,
          concurrency=1)


WAIT_TIME_SECONDS = 2


def run_sample_task(**kwargs):
    order = str(kwargs['order'])
    execution_time = str(kwargs['templates_dict']['execution_time'])
    print(f'Running {order} task at time: {execution_time}')

def wait(**kwargs):
    wait_time_seconds = int(kwargs['wait_time_seconds'])
    sleep(wait_time_seconds)


first_task = PythonOperator(
    task_id='first',
    python_callable=run_sample_task,
    op_kwargs={
        'order': 'FIRST'
    },
    templates_dict={
        'execution_time': "{{ ts }}"
    },
    provide_context=True,
    dag=dag
)

wait_task = PythonOperator(
    task_id='wait',
    python_callable=wait,
    op_kwargs={
        'wait_time_seconds': WAIT_TIME_SECONDS
    },
    dag=dag
)

second_task = PythonOperator(
    task_id='second',
    python_callable=run_sample_task,
    op_kwargs={
        'order': 'FIRST'
    },
    templates_dict={
        'execution_time': "{{ ts }}"
    },
    provide_context=True,
    dag=dag
)

first_task >> wait_task >> second_task
