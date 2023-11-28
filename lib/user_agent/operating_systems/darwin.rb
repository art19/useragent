# frozen_string_literal: true

class UserAgent
  module OperatingSystems
    ##
    # This module provides mappings of Darwin Kernel versions to various platforms.
    # The data is provided by https://theapplewiki.com/wiki/Kernel
    module Darwin
      # A mapping of Darwin kernel versions to iOS/iPadOS versions
      IOS = {
        '9.4.1'  => '2.1.x',  # also 2.2.x
        '10.0.0' => '3.0.x',  # also 3.1.x
        '10.3.1' => '3.2.x',  # also 4.0.x and 4.1
        '10.4.0' => '4.2.x',
        '11.0.0' => '4.3.x',  # also 5.0.x and 5.1.x
        '13.0.0' => '6.0.x',  # also 6.1.x
        '14.0.0' => '7.0.x',  # also 7.1.x, 8.0.x, 8.1.x, 8.2.x, 8.3.x and 8.4.x
        '15.0.0' => '9.0.x',  # also 9.1 and 9.2.x
        '15.4.0' => '9.3',    # also 9.3.1
        '15.5.0' => '9.3.2',
        '15.6.0' => '9.3.3',  # also 9.3.4, 9.3.5 and 9.3.6
        '16.0.0' => '10.0.x',
        '16.1.0' => '10.1.x',
        '16.3.0' => '10.2.x',
        '16.5.0' => '10.3',   # also 10.3.1
        '16.6.0' => '10.3.2',
        '16.7.0' => '10.3.3', # also 10.3.4
        '17.0.0' => '11.0.x',
        '17.2.0' => '11.1.x',
        '17.3.0' => '11.2',   # also 11.2.1 and 11.2.2
        '17.4.0' => '11.2.5', # also 11.2.6
        '17.5.0' => '11.3.x',
        '17.6.0' => '11.4',
        '17.7.0' => '11.4.1',
        '18.0.0' => '12.0.x',
        '18.2.0' => '12.1.x',
        '18.5.0' => '12.2',
        '18.6.0' => '12.3.x',
        '18.7.0' => '12.4.x', # also 12.5.x
        '19.0.0' => '13.0',   # also 13.1.x and 13.2.x
        '19.2.0' => '13.3',
        '19.3.0' => '13.3.1',
        '19.4.0' => '13.4.x',
        '19.5.0' => '13.5.x',
        '19.6.0' => '13.6.x', # also 13.7
        '20.0.0' => '14.0.x', # also 14.1
        '20.1.0' => '14.2.x',
        '20.2.0' => '14.3',
        '20.3.0' => '14.4.x',
        '20.4.0' => '14.5',   # also 14.5.1
        '20.5.0' => '14.6',
        '20.6.0' => '14.7',
        '21.0.0' => '15.0',   # also 15.0.x
        '21.1.0' => '15.1',   # also 15.1.1
        '21.2.0' => '15.2',   # also 15.2.1
        '21.3.0' => '15.3',   # also 15.3.1
        '21.4.0' => '15.4',   # also 15.4.1
        '21.5.0' => '15.5',
        '21.6.0' => '15.6',   # also 15.6.1, 15.7, 15.7.x and 15.8
        '22.0.0' => '16.0.x',
        '22.1.0' => '16.1.x',
        '22.2.0' => '16.2',
        '22.3.0' => '16.3',
        '22.4.0' => '16.4',   # also 16.4.1
        '22.5.0' => '16.5',   # also 16.5.1
        '22.6.0' => '16.6',   # also 16.6.1, 16.7, 16.7.1 and 16.7.2
        '23.0.0' => '17.0.x',
        '23.1.0' => '17.1',   # also 17.1.1
        '23.2.0' => '17.2'
      }.freeze

      # A mapping of Darwin kernel versions to macOS/OS X versions
      MAC_OS = {
        '12.0.0' => '10.8',
        '12.1.0' => '10.8.1',
        '12.2.0' => '10.8.2',
        '12.3.0' => '10.8.3',
        '12.4.0' => '10.8.4',
        '12.5.0' => '10.8.5',
        '13.0.0' => '10.9',    # also 10.9.1
        '13.1.0' => '10.9.2',
        '13.2.0' => '10.9.3',
        '13.3.0' => '10.9.4',
        '13.4.0' => '10.9.5',
        '14.0.0' => '10.10',   # also 10.10.1
        '14.1.0' => '10.10.2',
        '14.3.0' => '10.10.3',
        '14.4.0' => '10.10.4',
        '14.5.0' => '10.10.5',
        '15.0.0' => '10.11',   # also 10.11.1
        '15.2.0' => '10.11.2',
        '15.3.0' => '10.11.3',
        '15.4.0' => '10.11.4',
        '15.5.0' => '10.11.5',
        '15.6.0' => '10.11.6',
        '16.0.0' => '10.12',
        '16.1.0' => '10.12.1',
        '16.3.0' => '10.12.2',
        '16.4.0' => '10.12.3',
        '16.5.0' => '10.12.4',
        '16.6.0' => '10.12.5',
        '16.7.0' => '10.12.6',
        '17.0.0' => '10.13',
        '17.2.0' => '10.13.1',
        '17.3.0' => '10.13.2',
        '17.4.0' => '10.13.3',
        '17.5.0' => '10.13.4',
        '17.6.0' => '10.13.5',
        '17.7.0' => '10.13.6',
        '18.0.0' => '10.14',
        '18.2.0' => '10.14.1', # also 10.14.2 and 10.14.3
        '18.5.0' => '10.14.4',
        '18.6.0' => '10.14.5',
        '18.7.0' => '10.14.6',
        '19.0.0' => '10.15',   # also 10.15.1
        '19.2.0' => '10.15.2',
        '19.3.0' => '10.15.3',
        '19.4.0' => '10.15.4',
        '19.5.0' => '10.15.5',
        '19.6.0' => '10.15.6', # also 10.15.7
        '20.1.0' => '11.0',    # also 11.0.1
        '20.2.0' => '11.1',
        '20.3.0' => '11.2',    # also 11.2.x
        '20.4.0' => '11.3',    # also 11.3.1
        '20.5.0' => '11.4',
        '20.6.0' => '11.5',
        '21.0.0' => '12.0',
        '21.0.1' => '12.0',
        '21.1.0' => '12.0.1',
        '21.2.0' => '12.1',
        '21.3.0' => '12.2',    # also 12.2.1
        '21.4.0' => '12.3',    # also 12.3.1
        '21.5.0' => '12.4',
        '21.6.0' => '12.5',    # also 12.5.1, 12.6 and 12.6.1
        '22.0.0' => '13.0',
        '22.1.0' => '13.0',    # also 13.0.1
        '22.2.0' => '13.1',
        '22.3.0' => '13.2',
        '22.4.0' => '13.3',    # also 13.3.1
        '22.5.0' => '13.4',    # also 13.4.1
        '22.6.0' => '13.5',    # also 13.5.1, 13.5.2, 13.6 and 13.6.x
        '23.0.0' => '14.0',
        '23.1.0' => '14.1',    # also 14.1.1
        '23.2.0' => '14.2'
      }.freeze

      # A mapping of Darwin kernel versions to watchOS versions
      WATCH_OS = {
        '15.0.0' => '2.1',
        '16.0.0' => '3.0',
        '16.1.0' => '3.1',
        '16.3.0' => '3.1.1',
        '16.5.0' => '3.2',
        '16.6.0' => '3.2.2',
        '16.7.0' => '3.2.3',
        '17.0.0' => '4.0.x',
        '17.2.0' => '4.1',
        '17.3.0' => '4.2',
        '17.4.0' => '4.2.2',
        '17.5.0' => '4.3',
        '17.6.0' => '4.3.1',
        '17.7.0' => '4.3.2',
        '18.0.0' => '5.0.x',
        '18.2.0' => '5.1.x',
        '18.5.0' => '5.2.x',  # also 5.3.x
        '19.0.0' => '6.0.x',  # also 6.1
        '19.2.0' => '6.1.x',
        '19.4.0' => '6.2.1',
        '19.5.0' => '6.2.5',  # also 6.2.6
        '19.6.0' => '6.2.8',
        '20.0.0' => '7.0.x',
        '20.1.0' => '7.1',
        '20.2.0' => '7.2',
        '20.3.0' => '7.3.x',
        '20.4.0' => '7.4',    # also 7.4.1
        '20.5.0' => '7.5',
        '20.6.0' => '7.6',
        '21.0.0' => '8.0',
        '21.1.0' => '8.1',
        '21.2.0' => '8.3',
        '21.3.0' => '8.4',    # also 8.4.x
        '21.4.0' => '8.5',    # also 8.5.1
        '21.5.0' => '8.6',
        '21.6.0' => '8.7',    # also 8.7.1
        '22.0.0' => '9.0.x',
        '22.1.0' => '9.1',
        '22.2.0' => '9.2',
        '22.3.0' => '9.3',
        '22.4.0' => '9.4',
        '22.5.0' => '9.5.x',
        '22.6.0' => '9.6.x',
        '23.0.0' => '10.0.x',
        '23.1.0' => '10.1',   # also 10.1.1
        '23.2.0' => '10.2'
      }.freeze
    end
  end
end
