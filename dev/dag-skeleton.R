# TODO: Add simulated datasets here for the examples.
# TODO: Confirm return objects are correct.
# TODO: Confirm documentation is correct.
# TODO: Confirm that the .data arguments can be a data.frame

#' Estimate equivalence class of DAG from the PC algorithm.
#'
#' Is mostly a wrapper around [pcalg::pc()]. Estimates an order-independent
#' skeleton.
#'
#' @param .data Input data, samples by metabolite matrix (or data.frame).
#' @param .alpha_value
#'
#' @return
#' @export
#'
#' @examples
pc_dag_estimates <- function(.data, .alpha_value) {
    number_samples <- nrow(.data)
    metabolite_names <- colnames(.data)

    pcalg::pc(
        suffStat = list(C = stats::cor(.data), n = number_samples),
        indepTest = gaussCItest,
        labels = metabolite_names,
        skel.method = "stable",
        alpha = .alpha_value,
        fixedGaps = NULL,
        fixedEdges = NULL,
        verbose = FALSE,
        maj.rule = FALSE,
        solve.confl = FALSE
    )
}

#' Extract adjacency matrix from a DAG skeleton.
#'
#' Is generally a wrapper around calls to [igraph::get.adjacency()] and
#' [gRbase::graphNEL2igraph()]. Transforms from a GraphNEL object in igraph.
#'
#' @param .dag_skeleton The PC DAG skeleton object.
#'
#' @return Outputs an adjacency matrix of the DAG skeleton.
#'
#' @examples
#'
adjacency_matrix <- function(.dag_skeleton) {
    # TODO: Include a check here that it is a DAG skeleton.
    igraph::get.adjacency(gRbase::graphNEL2igraph(.dag_skeleton@graph))
}

#' Estimate order-independent PC-stable skeleton of a DAG.
#'
#' Uses the PC-algorithm and is mostly a wrapper around [pcalg::skeleton()].
#'
#' @param .data Input data, samples by metabolites matrix (or data.frame).
#' @param .alpha_value
#'
#' @return DAG skeleton object.
#'
#' @examples
#'
pc_skeleton_estimates <- function(.data, .alpha_value) {
    number_samples <- nrow(.data)
    metabolite_names <- colnames(.data)

    # Estimate order-independent "PC-stable" skeleton of DAG using PC-algorithm
    # TODO: Confirm that this does this.
    pcalg::skeleton(
        suffStat = list(C = stats::cor(.data), n = number_samples),
        # Test conditional independence of Gaussians via Fisher's Z
        indepTest = gaussCItest,
        labels = metabolite_names,
        method = "stable",
        alpha = .alpha_value,
        fixedGaps = NULL,
        fixedEdges = NULL,
        verbose = FALSE
    )
}

# TODO: Confirm that the .data can be a data.frame
#' Estimate Pearson's partial correlation coefficients.
#'
#' This function is a wrapper around [ppcor::pcor()] that extracts correlation
#' coefficient estimates, then adds the variable names to the column and row names.
#'
#' @param .data Input data of samples by metabolite matrix (or data.frame).
#'
#' @return Outputs a matrix of partial correlation coefficients.
#'
#' @examples
#'
#' partial_corr_matrix(metabolite_data)
#'
partial_corr_matrix <- function(.data) {
    # estimate Pearson's partial correlation coefficients
    # TODO: check if input data is gaussian
    pcor_matrix <- ppcor::pcor(.data)$estimate
    colnames(pcor_matrix) <- colnames(.data)
    rownames(pcor_matrix) <- colnames(.data)
}
