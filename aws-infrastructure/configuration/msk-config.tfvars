msk_configuration_name = "es-msk-cluster-01"

#MSK
msk_instance_type              = "kafka.m5.large"
msk_kafka_version              = "2.2.1"
msk_number_of_brokers          = "2"
msk_ebs_volume_size            = "10"
msk_encryption_data_in_transit = "TLS_PLAINTEXT"
# Make sure this number makes sense for the amount of brokers you have assigned
# e.g. if you have 4 brokers set min sync to 3
msk_min_in_sync_replicas       = 1
msk_default_replication_factor = 1
