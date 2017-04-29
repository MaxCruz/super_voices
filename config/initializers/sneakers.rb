Sneakers.configure  daemonize: true,
	amqp: ENV['RABBITMQ_BIGWIG_RX_URL'],
	log: "log/sneakers.log",
	pid_path: "tmp/pids/sneakers.pid",
	threads: 1,
	workers: 1
