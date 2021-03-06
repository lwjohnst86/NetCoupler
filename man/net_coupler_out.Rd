% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/base-netcoupler-functions.R
\name{net_coupler_out}
\alias{net_coupler_out}
\title{Estimating the outcome from a NetCoupler DAG.}
\usage{
net_coupler_out(graph_skel, dat, adjustment_data, DE, survival_obj)
}
\arguments{
\item{graph_skel}{Estimated DAG skeleton of samples x metabolites data matrix}

\item{dat}{Renamed samples x metabolites data matrix}

\item{adjustment_data}{Exposure/phenotype data}

\item{DE}{Indicator if direct effects were already identified}

\item{survival_obj}{"survival" object}
}
\value{
Outputs a list with model details and outcome estimates.
}
\description{
This algorithm estimates direct effect of a predefined exposure
(network-variable) on time-to-event for all causal models that agree with the
input-network: Cox prop. hazards regression models are used to estimate the
efect of all network-variables on survival time adjusted for all possible
combinations of direct neighbors (adjacency set) -> Output is a multiset of
possible causal effects.
}
