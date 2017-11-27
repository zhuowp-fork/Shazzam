﻿namespace Shazzam
{
    using System;
    using System.Collections.Generic;
    using System.Windows;
    using System.Windows.Input;
    using Shazzam.Commands;

    public abstract class ShaderModelConstantRegister<T> : ShaderModelConstantRegister
        where T : struct
    {
        public static readonly DependencyProperty ValueProperty = DependencyProperty.Register(
            nameof(Value),
            typeof(T),
            typeof(ShaderModelConstantRegister<T>),
            new PropertyMetadata(default(T)));

        private readonly T defaultMin;
        private readonly T defaultMax;

        private T min;
        private T max;

        protected ShaderModelConstantRegister(string registerName, Type registerType, int registerNumber, string description, T min, T max, T defaultValue)
            : base(registerName, registerType, registerNumber, description, defaultValue)
        {
            this.defaultMin = min;
            this.defaultMax = max;
            this.min = min;
            this.max = max;
            this.DefaultValue = defaultValue;
            this.Value = defaultValue;
            this.ResetCommand = new RelayCommand(this.Reset);
        }

        /// <summary>
        /// The default value of this register variable.
        /// </summary>
        public new T DefaultValue { get; }

        public ICommand ResetCommand { get; }

        /// <summary>
        /// The minimum value for this register variable.
        /// </summary>
        public T Min
        {
            get => this.min;
            set
            {
                if (EqualityComparer<T>.Default.Equals(value, this.min))
                {
                    return;
                }

                this.min = value;
                this.OnPropertyChanged();
            }
        }

        /// <summary>
        /// The maximum value for this register variable.
        /// </summary>
        public T Max
        {
            get => this.max;
            set
            {
                if (EqualityComparer<T>.Default.Equals(value, this.max))
                {
                    return;
                }

                this.max = value;
                this.OnPropertyChanged();
            }
        }

        public T Value
        {
            get => (T) this.GetValue(ValueProperty);
            set => this.SetValue(ValueProperty, value);
        }

        protected virtual void Reset()
        {
            this.Min = this.defaultMin;
            this.Max = this.defaultMax;
            this.SetCurrentValue(ValueProperty, this.DefaultValue);
        }
    }
}